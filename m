Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 07:01:30 +0100 (CET)
Received: from mail-by2nam01on0084.outbound.protection.outlook.com ([104.47.34.84]:64832
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990398AbdKGGBXBHDBJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Nov 2017 07:01:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iNvNBXTnj5X6KwJCh3vobBPj6MVXklmqWGHzP9Hdr2U=;
 b=Aq7qAr+NHMwCLk2cN2WOXTaTVQT1rVj4n9oHbCa2R0oZQXCENvOaK1j5pL8MONzNXCOnD69CPdp5jCulNNrwTgSgFFLRo0obdTo1c1P97K6PbuURUjjxAKmvv56WKd2NM6lEkUgt8K4P5ukhDiDjo6PbL5eHLAr9UQpRiBvEgik=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.197.13; Tue, 7
 Nov 2017 06:01:11 +0000
To:     James Hogan <james.hogan@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Urgent patch for upstream.
Message-ID: <0e020882-3de1-3704-a25a-d394fd874d97@cavium.com>
Date:   Tue, 7 Nov 2017 00:01:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: DM5PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:3:16::14) To MWHPR0701MB3803.namprd07.prod.outlook.com
 (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 938caa91-bf97-4482-9b9b-08d525a4f274
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:nCS3pFWofKAp1OQvidCEZpqDJvsR1akZGV21e61Sl74kwBJV/LY81I7ooBCzQlKQjuaFoIY3QwQ8TO09i5cB/MudU+vhqGN15tZSUF7ozJxNmdWqAWoZKkgpffi3IaoNmDAFy25tY4RrguKB6CFt5xSPmFcYrSfvv0Br1nn9E6yPG7hFAN8rlTjkna5Xvi8J7wKmx93xvjfCIRXao0JeCzyBht7SFNbUvNXADx4JWwqiwMGg5YJbht15rijhTJgI;25:I22IbmCYkaqYYRO+lTv5/53GJXUUumKLsaI9d2IsgnSnIKU2THj2v2YQlFcYlTyWtraC7WKhfBo7aN9o+NLW1Ix6TbtiQ1C0N/0N+mSkjwf6YCP3CF+9u9JDUr/rvm6zIbWnbY6KXHIAMoD7NlIT2yDk5Ss48F5BFmeSvdpzOtItCyRYhsc585FjB0Aq3sgqqHygHLCE502iLnpvJvJRzJgEREP7aKZskRrkZf7H5EeB+axw8IHkIBOE2NOzLF0jwmgTU9f5YtcRecwlDpL5WXbg0EMEKeexnb8Fv1eJ6QB0h4ySUiVb5ldvCiF/EkuKZ9qRcH/Vtho8rHIXWUosHA==;31:CyKTK3lld89+f6qVvlk8qBI/8azEs/C8zmWrlk2+9OGUyTZugquVjMRaA2CycrkBVnkyYVQ0P/Xn/9k6+y7Cg9jpNy79qIyui7NK6KqCp7NqmVdjfEt5yaLCrEPY5m8ISRRQtIdYeckk4Sd/SkFahRrOHM8mpaV5NU4wKwUdS1JB5S7ipzzkByJJh+n1HbFSvlH1HoENsSOZ7C+QAQqR/1IWykSXN/9+V5qml/rkXX4=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:CeqLzJxLKjqMAl18hJG+zfvKfex4COhhmkBT5cdkCBpnzjkj2W7KBQeb5OuwH31BfUhY3L+zRgNOaPUtLDSFc7fdeyTWylTJNqIC0RaprU0jTj9pa88IVIXhBzf+Uun/dvyyESV4vSuBWKHIFZjuwjIg/Da66ryRAU1fNXgzRkh9cSWWvJ5Tm5NuTOPgEEZXCe+y5E1v7JYYZGwckObe/iKGRcdsQHWjXqmTJwUgE+/uNoY3KbbP5lhuCRGgYlNHUkmzrnOSYRZm6FvgO9mGOGepFWOYpmet9NZjj0DZlCm0qBcoze95U9mmCEk3Q5+ZXBH1M/xwVGbE5MJJ66zdtOPVHJPXbq+VylUE970hXkOlljhcujmjVFOSC44rOqt/okbh+NQSzisxRvwrohIpSvukYK7YYTGIMfzJFye3SiZbZYp3CX+q+AyuFAMMbdXXuyKbR24LCpKomhCR89eMCM59mMsIa5QduHlE2T8AmvL/vQL1B/Mc1WUxY4su9J4a;4:PQs07mVHJIu4qqePL6rchpT2Oiz/E7bNTLLmjSlAGIAlKK5m3AufraM+dIGaGFywU5tG6e3fROikEEnzfAjskN1s4GhNMk+LcU2/xAMa9Vd+LeV/Y5aYluFaXI9S7W5jYXMYqjPjD0eMi9wQjjLzgog2zoiFRJdpbVQAL4Qn0vzUBjPPLxbMTtZj6JGlTWF8SEufevFW7MdHIvHd1GRuJ+NAOeeYNEMF74wffnuj4vbf4BIzjTYqAgTv8mBd9axKUAuaV2E8K4PBJE2tJEe5cg==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR0701MB38039793C1C686FF925A1A0880510@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231021)(93006095)(93001095)(100000703101)(100105400095)(6041248)(20161123555025)(20161123558100)(20161123564025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 0484063412
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(6049001)(376002)(346002)(199003)(189002)(6306002)(25786009)(110136005)(189998001)(54356999)(218543002)(16526018)(31686004)(58126008)(6666003)(68736007)(50986999)(478600001)(72206003)(16576012)(316002)(101416001)(2906002)(83506002)(105586002)(106356001)(3480700004)(65956001)(65806001)(66066001)(47776003)(36756003)(23676003)(50466002)(6486002)(230700001)(6116002)(3846002)(64126003)(33646002)(77096006)(558084003)(81156014)(81166006)(86362001)(8676002)(97736004)(53936002)(2501003)(8936002)(305945005)(7736002)(31696002)(65826007)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3MDFNQjM4MDM7MjM6TlZRUCtEaXpJWVY2cVpDWXRkTGpiNEJO?=
 =?utf-8?B?VEtQREJKWTd5Tyt6WHpjZUVnOTlmcDVxNnZ4c3ZYeHR5cVBQOWNPSnUyd0Jq?=
 =?utf-8?B?aU14bHNocGVkZEpqQVhtTEtPN2JNUnVRb2lzbE5TYU5iNTBSMHJoWHh1NDFG?=
 =?utf-8?B?YldMQk1aeXk5S2YvM0pNSVNZbm95ZVpVY0wzeDM5R3ZCcThXd1VyNWFkUU5s?=
 =?utf-8?B?ZzZLbWhLZGdTd2V6cHgvVFJiVkNMVG5oNHFweVRwMDhrRmZMeFRLbTluaEJB?=
 =?utf-8?B?eGJOenhlSWhpWmpteDhEZm1zOFZENjFsNG5uN0JjMUt3WkpBNnZoUjZTWTZh?=
 =?utf-8?B?ZWN0KzdtaTF2RWtjV1UvQjVGUWRnSnpkQU56YjUyRUQ3d3BseUxBRGZUZm5h?=
 =?utf-8?B?OHhDWTRnNnpVS2ZHUXlRT3VFdy92MkZRelpMZ3ZsWGhQWGR0clVBZktOV2l0?=
 =?utf-8?B?TFA1MHBnVUtXd1RvOG1QUFlHRFMzaFlNS3dRaGFnZnZFME1VY1AwcnZlblN5?=
 =?utf-8?B?Q1p6RmtScFNiVmFReks4YzhFR0JmUS8vYWNtMnV3V0kyL00vMGpKelZ0UDgx?=
 =?utf-8?B?Zit6UnBEUXE3ekQzLzZtbUJxN283cWpjZGpxZXJBM2JYMGs3blFkNmU1Lzcv?=
 =?utf-8?B?VXRXNXFCMFpIaFBsOE1VMEhIbDR5anU0ZWUyb01GN0pRS1J6blRLRmx5MTZo?=
 =?utf-8?B?ZUhtVnR1dWVMMUVNd0xQZEozcnZmZ1o1RWhlRTdVS1pINU00YWNVdzl0Y3JT?=
 =?utf-8?B?cTQ1K2Fkempjc1RCV3o2VVJ2TFA2U0M5a3hIWHZqdjRqMElUa0JoUE1yM3N1?=
 =?utf-8?B?a3FPZ0c3emFUYTVTMG1oV1Z1OU55NVVpbXA2Rkl2N1I4ZlRNYjNWUW92ak8z?=
 =?utf-8?B?U2hqTGhWYVQ5bTJ6Q3MycnFaZjF1U3RCQ1I5bzRtU3RyQm1tN1h5RHJhb3pY?=
 =?utf-8?B?S1pnay9vc25tOXZxNlg2dTR0dFNxbmJmRVpRNVVwbXkySzRuaDNRc0pWb0FG?=
 =?utf-8?B?OThIRmRNR3dvb1d6WXgxQUdCWVd1WGJrWTcwMEkrMld6OFc4QytVUmpGazJU?=
 =?utf-8?B?ZEJnRFBjaWNhL2RJK3AwbDd3WTVLdE9iLzZHbWNGSGxNR29vMGhKWUJPVWFR?=
 =?utf-8?B?U3paT3dqOE9YTG1Ka0Rqbk1NNzgxQnNId3ZRaW4xbjU3VnZ4RzN0c0I5VlNW?=
 =?utf-8?B?VWp4aXFnTTZYUmlyV3hJcGZqaXJGUDhUbWxacU1lZlFJaU9EdG1YOFdDVG4y?=
 =?utf-8?B?c0lsMjUxVktGR0szdDN4VGVnYzNWK25wZ2pCa1RiV1lPRVgxdU5VSkJyWmlV?=
 =?utf-8?B?MWpmWmZsT0tDOHA1Ky9ZaHpaRnI0MEVkQk4rVUQ3TkVHNDZCNHpja2JRUjR5?=
 =?utf-8?B?aTBKZmYvZ2prR3BwTnVvRzFHZVJhU0ptZFBLUHp0c1dEeGFDT0tTU3IrYnRZ?=
 =?utf-8?B?ZHRKRy8rRUtjdFdCZmpXRG1VcmZLTERHRWVRZFUyOW9vdTYxWlVha0JzcEEv?=
 =?utf-8?B?dVFPcE1BNS9zazFZbFNjaGJiM295dGV0SGx0Mkdrclltc2NaQ2M4R3ZnbjEx?=
 =?utf-8?B?QmY5NEFuUk9adWp4c3pRL0lEeWFLVUJhM2tMbSthbEFkbnRNeFZJVGQycmpK?=
 =?utf-8?B?dklPYVNyNXEwdUs3QWR2cDdqeW5QRk1tSndVTi9jS05sb1JtSnJvUzRBV1N3?=
 =?utf-8?B?b09wRTVKQjFJSG9lMU9qWnNURTB1QlRpbmMzd1ZqRXRDSmVsNTJDc2phQ2k4?=
 =?utf-8?B?eDIwZWZrQWJvMEZZSWhQN0V3PT0=?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:dk9gyv4EIrUPOBIkbsGuXpUmxc92GaMGtydP1+mHYF9uw31nlcjUwUMwFSoFAw70LpRMjVuMjolsHVqa2JMDLDK0QRkVEGk1+GKw92LgWV745L6yZQPZMrChLzY5AOKn2krc8ZDLcHvRHaw7Nvz7zvjp/F3eo+ZyfMWOrJME8HYlE6RM1kICVjyBAac7eAZX4LVoxZvo1dA6tG7idKS+3t87my+NnQk+1el28H3XB5iYxSpV85KCKqDrRfmmmtCJO/je+5Ws40blM9nXTBe8hgDSwzRLBbJRplWmvPyqrH1VnPC0HAfIV802MlBRjxagcJTekhS3wUNeDOTOvsTmUcDWySXqG6uNonxbOGBiWIE=;5:z4bF1bZ6TIeQMsUfwdXeP/HZiI/OitdB44zJ+UL7qHLhn+0MA5UN80t7ToM3uYe5g2h672SWZtQJ+yhkj8QJo+7OlF9f/MB5I1J2eE7DtjBNlwaqMF4RuiqArW+yW4lF+x0JeA4AO2E4aXscdCqQ5TfPMkFbuWjtwrT4odO+YLk=;24:wjCrTDKvuw4Iq4Y+4x591nbVequCwFOYF1VWMkQ0XJ+0W029hQM2GaJB1wxYHaAToWZJ/ekVzUR9lnrkny79SrbY+PPJRZ53Hd0L9VGW+AY=;7:nq/hxKwtN5sstPhfBJn2944TzQQxpHY/SsHfNC0J8Vk69KHepDbepxGp/kDGQeng5uh00okjpM4u/MFPYsBgu064Z009Val0JfahdcMyn8pVW1vqf7qY7s0sYqQccW2hVpmDXZGus1v34o7Gp/4IZQ8bCp1oz5vZYq+9tnkSp9+NGaByjaBPWFaMyLuSdOWM+XurgbsVzJAR/S8zusiOBKKg4D97darFdD1mXye2dFwKVLVJXJxficd7/HtH1bXg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2017 06:01:11.0385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 938caa91-bf97-4482-9b9b-08d525a4f274
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60735
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

James, et al.

The patch <https://patchwork.linux-mips.org/patch/17400/> really needs
to go into 4.14 to fix MIPS build breakage. 4.14-rc7 does not have this
fix. How can we get this upstreamed?

Steve
