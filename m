Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2018 07:16:33 +0100 (CET)
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:3428
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990418AbeCXGQZ5R2NG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 24 Mar 2018 07:16:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LiWC4VNDjoOSDnnATJO12wVxPXX3gl7aYJjAhK8LtB4=;
 b=mDz8zvR2yZ6PeBuTCTyLSFPvyxdIZyrt0QD2JfR5EV3vyNNLkD6lMnq0yvM0HKKjMMBdQP/esHw7U+t58TH7vlUPdqGq+eZHROj8Z3uLeHkcZNsy3PlL/HSM7GU9svkG6+HeH9gKVajMSjQ2VWs0dIbmrzB47ymVAF/a8B5s9YU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.40] (50.83.62.27) by
 BN6PR07MB3603.namprd07.prod.outlook.com (10.161.153.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.609.10; Sat, 24 Mar 2018 06:16:15 +0000
Subject: Re: [PATCH] MIPS: Octeon: Disable PCI support.
To:     James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org
References: <1521789166-6096-1-git-send-email-steven.hill@cavium.com>
 <20180323211854.GE11796@saruman>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <4e466cdf-c60a-7e2b-dbb2-2e94d8dd2385@cavium.com>
Date:   Sat, 24 Mar 2018 01:16:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323211854.GE11796@saruman>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: DM5PR15CA0064.namprd15.prod.outlook.com (10.173.207.26) To
 BN6PR07MB3603.namprd07.prod.outlook.com (10.161.153.158)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c19880c2-6fc2-4518-27be-08d5914ebfdf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB3603;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3603;3:bllVaSkxtiG1cDTTbEIvcJGq3idGqEiLBzxRozrEVDpkSlA8mZJWw74rks+16Yfb95/cUXHfRqsi0jeC5Ga/G7FGPIPAePx+DjSItmQgI+cXe8EfE2Ww/vivEqcyAG6WR/Vf0tw1wIIBc607cGDvWkzP0smsRJbjPbcQSdPLRIj/5rYBs8P0UHanlcPP5G2CohApklyuq6LrejKTW2dNwOVy5YYzAXEcZhMuFBW++/IBCRnARtyzhrRQIvc3MYHX;25:lzg2w4pBXBZ+cDn4oQMwrZq5FPLCqnhugp+PJwSwhHHzs6/L/bsWFC/SngRxqbLrbJPxlczJg6B2uTnWkROIUO/OdsUyVzusfsV86SXva4jw1bBWciaU59bh3miVP9Y3ykcrMhPVvMDcr5OL0cOuwcnHmb11XjIoObzvTzQbjIZG/F1HBVgdhPTtByVL4rfwmhc2S0DL+bz7bNaXEcc0vXGuQukfTR6UbHxa4YbqVJYdKTqfwf4/URwkRL4YeAosqB5LILeURg7f7/v/GVuyq8WG5MG74X5tGCALJoLGGHmZx7mkY7/YpEC4mX4AryJ/fn3AAoRYVD9neOFVBU5tIw==;31:zFfY8AdCjrT5rP/xa0eIYwHQQ44fhwHHfs+08KZxjW/z5ESJRIYisi17xwIrGV/ElkOSs04ykyfZUXlcrnBiL9DSF78lkvNzPHNXd0yefWU0fMCVbNiZcEt4GtqYGEbnHoruUmxWnkK7GrA+r0JqW8HWFCavVz2E445fsh72DDG7pvFLkUDojcAymCLE8b1mkGjN86pVwrl/UodvPgz6ZDn08xT1Y1JLnplCZmL4v1w=
X-MS-TrafficTypeDiagnostic: BN6PR07MB3603:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3603;20:MAirW4rqhCq2th+a9vAgAV8NOunhUSlrQ3A3AN62zJC4uTMyiGZ/vQxWYPC6dHtMnWpfU0RlRlDq0GgqHT5sN9G/t04OtwM5Nw38QktjKZHRg9XE1ZuqzWd5Y8aKeZtP3rI/h5VndRQDQCmoXAoeSCIq1WjVZwNwhtS2WxJot4Q5bi9dvYE7IqaAYwjO1pQxiSSHYPW/iggEE/nwab8ytyGuojmC0EZeblzVKT7jtv41x1uPJK++m6DosCRbqHEdjb7ice9DpxzAQQ0Hh5ZBjhGr1OwWnAaACrTKtsTREjpGGBcNiwKDeykOKmrrUBAH9WtiQ8VQIk7zjmw6VmglPv9rlVMHUKz4Fj7y4QblfgzhZMECmJD1NGWAcsOU6zVPytLJDXwk7N9iIVz2IgqUjr5r1HK/ix2N2Qx7CMJmwLymZpUaL7uyZO51BOvMM5U7TSN+Bjv7dYkwXUZQd8BXjyvnt0Cdg8eZADpRimr9aO6NsSqZ2ziVmf19jjM4IYzX;4:VPDQL56pRq3BbOERiS8WBOApEvD9ZBTU95D87E8lkE/zakvLL1wGf3EdBYVTxuQY9+kXAReoeeW8Aly90IXUAhhB3f9Fl2w21PsKoeXpJDf9zMYDo4xn93razSRydpE+WpqfHebIBFo39/GM4AccJPNz22IX2AABAPIHj91G6MnUXUMlQgfygr0rIgSF0WXJqjcpVQ0eqo6UV4Vyp+5T6ALsEikQYbqqTIvNQEHV4MX+qro6rNhoDzPwPcsh/gkDu3hkSEeiQFflm7F2R1iPqQ==
X-Microsoft-Antispam-PRVS: <BN6PR07MB360344DEF0997E49FB21601C80AF0@BN6PR07MB3603.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR07MB3603;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3603;
X-Forefront-PRVS: 0621E7E436
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(366004)(346002)(376002)(396003)(189003)(199004)(58126008)(47776003)(64126003)(36756003)(31696002)(23676004)(50466002)(65956001)(66066001)(229853002)(65806001)(11346002)(5660300001)(52146003)(52116002)(31686004)(65826007)(2486003)(97736004)(6246003)(305945005)(7736002)(6916009)(6666003)(76176011)(230700001)(6486002)(16526019)(72206003)(90366009)(386003)(4326008)(53936002)(81166006)(81156014)(26005)(53546011)(8676002)(77096007)(25786009)(558084003)(446003)(478600001)(316002)(86362001)(16576012)(3846002)(8936002)(105586002)(6116002)(186003)(68736007)(2906002)(106356001)(2616005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3603;H:[10.0.0.40];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzNjAzOzIzOlZ0aU9Vd2F6WVhpUS9TOW9QUXpRamZqVEpO?=
 =?utf-8?B?SldiblhhNW51eXJPYjgrWVlsSC9RS21mUEZpMFJ3dTNQeXc0Zk00Sm1OK2Ra?=
 =?utf-8?B?RzQ5UE1yTzErSFRGMDAvRy9qbVo3RHpnSmlYd0tQSHZUT2RhZ3EzN1NzRUxM?=
 =?utf-8?B?MzBxdWJOUmllRUk1dGk5UlE3Q3l6ZkErYmpIdkFKZTJQdHovUWVpdWRMUDRt?=
 =?utf-8?B?QkNLV21VdGppZFhrU25qdVZ3MkRvemowNXdxV3dwWDZZOUhqeGRvWFFGU21U?=
 =?utf-8?B?cXY4UFgxZE5EOE4yWGdoaFNrcFltS2hkWnV5QWxObkt0aG95Z2FOQk01TDZ6?=
 =?utf-8?B?NWRZVThjR01HcHNBZm5zNGp6SHE4TXZDb0Uzc0FkNWkxeU0wNXFKMG9PV0dw?=
 =?utf-8?B?SVZXTGlBaGdON3IxQjRCaC8yeXB2Tk5HMDdBVzhBalVpZCtSbkFRTFZFelRs?=
 =?utf-8?B?ZzQvNVNPTGoxNERjWm5MWTFORzNWWkdqTnRneW1FTWdBS0FsZ09nK2s1VXJo?=
 =?utf-8?B?cmlPczNPNFdnTTVwblZTenp3WHZqRklFRk0yaFNkek1tdHVzZ0JEbWR6SlV5?=
 =?utf-8?B?VTdqeFZSTUVQTzVhVWV5aGlyelBvU09XY0ZsK1k0Q1ZmQzV6OVhPVStzdmxk?=
 =?utf-8?B?aFBQOEZwZ2w4QSsxK2FodlRrYlFKMDdZTGpMQ1dSWk96R0tKS1N4aFdmd2FP?=
 =?utf-8?B?UExJelRDQXVvVE1EbnVGM2RqbEtwMi9iWStZS3Z3U2JpVllDdmtzU1UrczlS?=
 =?utf-8?B?QmdIK3BWbHErTldmZ3hSUFNQK25FUGY1K0NKMlhEd0FXN1dJd1p3MnFjblYy?=
 =?utf-8?B?cTJhZXRueEw3dXdVbnI4QUQ3VHdIZEhzRFU1NXRENWUrSjFNTmlqYlN1c3NT?=
 =?utf-8?B?enl4S29qUy9teTMxbHlRK2d1Ukx2K2srNVJpRCt4Wm1SMWszQS81NDBtbTRU?=
 =?utf-8?B?ZmN6eHhpNy9INWJsZ2hNS1RXOURCaEJ6YnRVRGoxMHVQOGF0cElrejd6SWY4?=
 =?utf-8?B?bW5ib2J2ekprTXgzRzl2allzV0hJdm53azJiVGN3MkdrVHEwaldaaU5FYnpo?=
 =?utf-8?B?RURDNldoaUNBMEV0RkJoUjN0ZTZsM1oydlhVR0p6d2Exck96MVpUY1dIaHRR?=
 =?utf-8?B?QjZ3YzFoNW5ERlJEd3hTRTdlNzNxYVppSzZWT2tINnkra0prY3JEODJLQndB?=
 =?utf-8?B?RUtYOEZlZWxBeEdBY1V4dDZOLzNKcHV0RWJBOVpiTDl5QnIyN3VZMG1vUW1D?=
 =?utf-8?B?WHZRZzhaVXdYVnJkR2VORENLdkYrSlJkaXIxeFlGYitpeUdvTnNIWVZkN3dm?=
 =?utf-8?B?dHF6b2VsY1owWVNlakY4Z3ZXRS9HYjVLdlJuVDJGUmJDU2xhbXE0WHdJODJG?=
 =?utf-8?B?aWFNSzRxT3FaUDJlT3o0NTMzQ0RuNXJEV2lpY1F4RDFGbm43VE9iMEt2R3Jo?=
 =?utf-8?B?Qzl4TWNiR1lqWHE4ek9yRWVGbzFIMzVzRWRwNDMzWXRGQSsybUhmUUxrRkVQ?=
 =?utf-8?B?bkZnN3lxRnU5QzE3cG4yU0pQY1NiL1dxaHg3QUR3d1RmOExpMUhVZVpleUVv?=
 =?utf-8?B?ZzF0MlZaYWUybmtsNHRUbllBMlNrb0hhTDFGenpPN2ZtMzZKNnpTZkpHSGxZ?=
 =?utf-8?B?aEJKS1pKR1ovZW5LQWt0bFp5NThvdEMzWnZRa0hZbXdTbDF6SkNGVUNjS216?=
 =?utf-8?B?Sks3anZmcnl0V2RISndkVnhKWDl4TU5kVXBXQm1sTnRFMzBiUTdwK3RvdGxq?=
 =?utf-8?B?VGdLSzZoNUtLVk4xMVlDaG1YL2FTUE5mb0xUbENvWHhURFpEMWE0aDdmK21t?=
 =?utf-8?B?SFRuTGp6RkpMeXY0dE96QWkxMUhubVczZnpabktac2JHdjFJRjZaR1BicW83?=
 =?utf-8?B?aE9MNjE5elF6ZmZWQXNaQllJRFNVbVFteE0xdnZKK2sxbFF0Mm1ybGlub1dl?=
 =?utf-8?Q?a3Qy8IuKm2HGizPFgb+tT61bo+vm1U=3D?=
X-Microsoft-Antispam-Message-Info: cFVDbagdS/fjPCZypJ80MDS31ZL/sPZAHR7NszDLq0b4Elda/B7a52+EDSkuAsV2dTdgOz9Tc27DihAAI/r6MpVA+jZXyYZ2ojs3soiDIX1gl3/V8Ox5ZK2e7sZskMieWLyHdei0QykhyWkM+LDunC8H/WZoQFp8xfyyiTnClUEjmRb97t218zOOaIz/IHH1
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3603;6:xRvd2VSvjWnypILZKgAREwMdcQuDEIft8Atwb+nntYBHMURv5CjIsjIzdssJbWAzsUMWlpMy3ajl73XZt9xI6x1OBV/Zt8i2gCiPzM9JuuMzITOrT/dU1exS+H7VR6453LQ6HO0hkjCaXWl7zo3uYwU0tn+XBzZW4UmLJkyLCrH0eK6rCb4GAWj3BOsgvbrhBp2PiMeyKX/F0TUFlQXJ/C26fFBG6JrLoHTecbiOyRxI9S3auVvM/YMpx/2KphcRI86ediDgEZQusBWZA0ZFTffll8eGVRz6UTholtvbnHExSLTv8N8VEkph7OE0wbYJgSa5Twu224yYdETQfAOnWHmwf72maTi9vFmrsASOfjCo9WDQlTSf99suGvtN+XjDr2nfdnNSGQGuSIu8gNgOhXrmmMynFDU3G0sKOSAkQTnmhJFpYJBk0fWYtSSczIbn6G+byrkmTQVyUlMxpd6b4A==;5:5rTt8gmL7amuLViq7/u36ifRSGXLJaVjcq+YUyEudqydvQXygiHFB97NpyI2RchaKwtQv8YPPvMIttr27xO4LUmZpFh2BrAyreYrI8lhG8P7to9JkTH7N41fZVQ5XPeNU0Jm8Bu+noD6ebufP8E4RdKTt0nNqIOGBJ2VUYptRDs=;24:1QzpLhjdtgpglQmr8j8I1jL2OTx1IzIQ4pn2TH7iq4dWIlYiKvkgTqF/g7GQUl5ZPEbemZ/j+NHtdvUcI2n9jTmDB0OIlur/Gd7fKK9Rsto=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3603;7:W8Z6rxXTSR+U4IQ03eSeFw+3coH2h3dkRvNlrQt+ol0oudWt5vya0xpFJJO+COOBO2eRmbHQOKAKbs0277TVOZLUZ1LqFk5E0ShK4kvS3JcMFaS20uBGLkPeg8XLCrBL96TY2EwiX0X+NcAIGkBewOl0phNJxBPl7OxCyw+3a/0ACtvzir8e8OzvFSy7MGZ/+mr0K8y2UFZFntOPAIaqTtFelgD2rCfKF0knMrHywhvqkLrCmQLMmBnL1aVj+EsQ
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2018 06:16:15.0499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19880c2-6fc2-4518-27be-08d5914ebfdf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3603
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 03/23/2018 04:18 PM, James Hogan wrote:
> 
> Could you clarify what build failures you're seeing please.
> 
None. False alarm, toolchain issues on my end.
