class ApiEndPoints {
  // static String baseUrl = 'https://mechanix-api-production.up.railway.app';
  // static String baseUrl = 'https://mechanix-api.vercel.app';
  static String baseUrl = 'https://api.mekanixhub.com';

  //Authentications
  static String loginUserUrl = '/api/auth/adminlogin';
  static String sendOtpUrl = '/api/auth/send-reset-password-email';
  static String verifyOtpUrl = '/api/auth/verify-reset-otp';
  static String changePasswordUrl = '/api/auth/changepassword';
  static String updateProfileUrl = '/api/auth/editprofile';
  static String updateProfilePictureUrl = '/api/auth/editprofilefile';

  //UsersManagement
  static String getAllUsersUrl = '/api/user/getallusers';
  static String approveUserUrl = '/api/user/approveduseraccount';
  static String deleteUserUrl = '/api/user/deleteUserAccount';

  //Analytics
  static String dashboardActivitiesAnalyticsUrl =
      '/api/analytics/dashboard-activities-analytics';
  static String dashboardActivitiesCountUrl =
      '/api/analytics/dashboard-activties-count';


  //Custom-Template
  // static String createCustomTaskUrl = '/api/formbuilder/save-custom-form';
  static String createCustomTaskUrl = '/api/formbuilder/save-custom-default-form-template';
  static String createCustomTaskSendIdUrl = '/api/formbuilder/generate-pdf-custom-form';

  static String addCustomTaskFilesUrl = '/api/formbuilder/upload-files';
  static String getAllCustomTaskUrl = '/api/formbuilder/getcustomform';
  static String updateCustomTaskUrl = '/api/formbuilder/update-custom-form';
  static String deleteCustomTaskUrl = '/api/formbuilder/delete-custom-form';
  //Analytics
  static String getAnalyticsUrl =
      '/api/formbuilder/total-counts-for-user-activites';

  //Engine
  static String addEngineUrl = '/api/engine/createenginebrand';
  static String getEngineUrl = '/api/engine/getenginebrandpagination?limit=200000000000000000000000000000000';
  static String getEngineBrandById = '/api/engine/getenginebrandbyid';
  static String updateEngineUrl = '/api/engine/updateenginebrand';
  static String deleteEngineUrl = '/api/engine/deleteenginebrand';
  static String updateEngineImageUrl = '/api/engine/updateengineprofile';

//Category
  static const String getAllCategories  = '/api/category/getAll';  
  static const String getCategoriesData = '/api/engine/getenginebrandpagination?limit=20000000000000000000000000000000000';  
  static const String addCategory       = '/api/category/create';  
  static const String updateCategory    = '/api/category/update?id=';  
  static const String deleteCategory    = '/api/category/delete?id=';  
}
