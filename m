Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 17:26:33 +0200 (CEST)
Received: from mail-bl2nam02on0056.outbound.protection.outlook.com ([104.47.38.56]:30046
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994658AbeDPP0YQfObm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Apr 2018 17:26:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ACVSEv8cB9NEpsoaNHet79O2zwkicoSgcEZI1oB8hO4=;
 b=b89P+vG6qC/EUzK7myp34OOl58bhDQvapzSFACt6GZqTkI2KlbnVZDCSUnO4w+I9/LctdPMb2xPCffP0i1PbT/HwEQ7BzOb3D60gxGSIHDmdQntiVRnNNwOLh3eh79Ede+9oS6qxzhFzCjwXuMS52A3S2n47hJloEDWgSe8Hp2c=
Received: from [10.0.0.40] (50.82.185.132) by
 CY4PR07MB3605.namprd07.prod.outlook.com (2603:10b6:910:76::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.10; Mon, 16
 Apr 2018 15:26:13 +0000
Subject: Re: [PATCH 4/4] MIPS: Octeon: Whitespace and formatting clean-ups.
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-mips@linux-mips.org
References: <1523650820-18134-1-git-send-email-steven.hill@cavium.com>
 <1523650820-18134-5-git-send-email-steven.hill@cavium.com>
 <20180414183819.czznxznuutfsw66j@darkstar.musicnaut.iki.fi>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <4496ef9d-d925-04e0-3d2a-9d1e0bc1e149@cavium.com>
Date:   Mon, 16 Apr 2018 10:26:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180414183819.czznxznuutfsw66j@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: DM5PR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:3:ae::17) To CY4PR07MB3605.namprd07.prod.outlook.com
 (2603:10b6:910:76::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB3605;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3605;3:NAlGotDV2AElfot1OqF7Hj6pUvHoCiU5ZHqHNBDLhCIrMwWsgCprfMYp47QqRF7xUEOqPRgca3QWSSjEKu2lHLwfcIl+QCjAwpkyIkBymq2cNm9oDxSt/KtuOAZVxNidwct4elj87WNLiOYswBdAnfIV4XkZsUJvvszu6330CC7Rm95GO7wB8Fbckn7J75laSu+i6TZlIQ/XBiX2B/lYBf5BP+ZLDxhdIPtIzFC6YeFY599c6bKKvcxJzNSGNpGp;25:zUYM2U+Ovr2thR863hgNC6X6r7ih0kptQxpA8AWIPh99dBn8FLpht6L+XbCfaP+QeYqKpIRbHf3FPXTQQyxIJGV4v3oiw5ocew99JsEuWy7HS4/uZWSMiysCMzwsWtyyQOpiakIuzwCmTWhX0/JyyWCBaukyyMwwsbjM2OVv18xQ+Jqib3JeD7WDUwYdGGKCFLOj+SIK+/Lja+pzpVStKp0IfwSrErcExUFjv29hb4OiXZbHRhTSP6H91zGsl3zmZ7SybtALkPsN84wM0MG3v1gkszEvchlhEHzALVSy8/C0xSlSqLpPQ/n9Q09UDn3AwarGLNCHwiM46CxsQLE0LA==;31:xq7xMDT7EZFhFBwtOK3tBDWYpwIaDVZMKqqknvdMAg2UNwIsSGWSxax9kKE2ooDGgN1db2yxVyPWEBUyv2rI647inORpHCXvOVXuZX6jWmTr82ddFi4ukIr3DgejN9ZuTydfT2LL2Ee4JWaRhO+3GnFO97aH0c9aK/sE31PvMEzG/nysTrDZ87ZwWaaIoE+sJeJVWjbP2ub4qQsfzdlW9otP6rGue/YD/pkH4fF+vvY=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3605:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3605;20:BTPWKXPp6dNOwndWHsdakVhmVR93chn7zxaTLRGMIJsvw8D3Fugp2/P7LtZdAD0ch2/mlU9HwcT71INSi1pbywWVvVX7/Tuj3KNeeo/YZWfv5A9+Fa9QeTVyzpPy2OgbAgBtDAMl6qj3d5ZjWZhU8ZLo+Cd5P9CEl67Egr5M0SM0hra2CdK6/bjrT3WAGZTg2SYlW6XAq2FVrfFtKk2/OR81fQI7+cvA1lb1sxXBLZajPV9DthLuJ7a0AFvGwH7mVkWTWKmAh5+mIy4J73oNIDZNIAw5g7akFtnUAeEwlr4/2fRVcCMArsHP1YZOgQIQVB5XLhgiQUBbdefZ4+IBJvt8bTkPpyWKLlAZm23Wb93tmSimII0OysIU3/93yb9SfrY92jwmvUDLoFipWh4BlYi56hfQpPI/qXANQmY8mmTtZ+jNI5ZH21P1V+qdP2m0wyoX1NLVhdHswM+UaMcu2M0ftdYYSbC2bjog0pX31XM4p4KbXny2KkGToN11v74X;4:hwIerwkmuzqNj95lSKXUac3j/c6vl3XNBP32ghvp0fSzXYkwyPOoLcCGTPTlKVhbAo3XjTg7u/UL0yw1o/LJgZqkyH9YqleB5JaUP/prYr4k5hHp+IRrAhcVx/+UlyM5Cil+ICfH40OQiiBi5kbENsuy2n1HiWmPDwGr6qzdD848Afa31MGurcj+RK8mj8w4iIKy1OyZs4u9gRDNE3DPltP8iN3skGXs05taeFSAwv59IQyY9Km6kH1WlKoM+koPnXED0CMqndZfQlFkIT/8vQ==
X-Microsoft-Antispam-PRVS: <CY4PR07MB360528C1F37BD7263B8006E880B00@CY4PR07MB3605.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR07MB3605;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3605;
X-Forefront-PRVS: 0644578634
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(346002)(376002)(39850400004)(396003)(366004)(199004)(189003)(58126008)(50466002)(6666003)(8676002)(6916009)(316002)(230700001)(386003)(16576012)(229853002)(97736004)(6246003)(64126003)(23676004)(52146003)(26005)(52116002)(68736007)(76176011)(2486003)(53936002)(6486002)(36756003)(2906002)(446003)(72206003)(6116002)(5660300001)(956004)(31696002)(2616005)(476003)(65826007)(31686004)(86362001)(53546011)(11346002)(3846002)(486006)(558084003)(4326008)(478600001)(47776003)(186003)(81166006)(106356001)(16526019)(81156014)(105586002)(66066001)(65956001)(8936002)(65806001)(305945005)(7736002)(25786009)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3605;H:[10.0.0.40];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNjA1OzIzOjc2enNlT1R2UmlnaHpGWVRmYzdSOTJTVWN3?=
 =?utf-8?B?Lzh6dThnYWYwdHFVVDl5SGxRTGNYNGxKalA3d0R4RTFQd3pEUHEvSUR4Zm1Q?=
 =?utf-8?B?K1hsOXg1SWhTeFBvRytkY2NPcWlqN3dNNTRYZU9OWUdmbmFDdUZBY2JmRDk0?=
 =?utf-8?B?aW1rbmhEeVQ2WXdrTjA4K21Mb1phMEpZaG4rbjRCMGdFS0ZyOEdhUjBNZk1w?=
 =?utf-8?B?bGpoZ2QxaXhmQVFqL3ZqekZwVlpKZkliRHlyWnRiOG1pR0N5U3ZsRmUrRy9v?=
 =?utf-8?B?NitIVmRiV0h1bEJTeDF6eUdHcFprbVR3WGN2ZkJ2QkNoaWN6M1VHWmx1Wk1u?=
 =?utf-8?B?RnQxem8vUnVoamdpRlgrZVhwaHNlc2gyTmNNcVBBSmhzN0duUlBOYjFadkxm?=
 =?utf-8?B?NzBLZTJaWm0rWDhzazQzZWFqWmo5S1J0VnlFeVRrVHh1TDgwOUU2M1VsSmNw?=
 =?utf-8?B?WVBxM2pyRmxCVU1MczFhRkI5U2thalhqTnBzbHVhWFlreWU1WnFCczRNMUdr?=
 =?utf-8?B?eU81TkFoUUpuZU1qRFlPOXdacTJmeXZuZVpTSGd4dlFKUkpCekxwQm1wUEZx?=
 =?utf-8?B?RlhlRHU5aWlpUUpKdGNZZTRSRHBpaGpUZ29POU5vYXQvOTNIYldmN3N1a3FJ?=
 =?utf-8?B?WE0xdTBaRVRFWDExNWU3ZVdPTkdtR2JLUTlaM1NjTmtmWnRpMkpRd2ZUTnRu?=
 =?utf-8?B?ZkFWZmV0SE00WnpqU1g1aVhiWDMzU0dyNXQ2Sk9OVEJWdlhvcjJZUms2dHNC?=
 =?utf-8?B?Zzg2aTBqV3JiQ0pwMlFZWWVvWW5ibXVKcTEreHpBa1JlZi9HeGtaS2NDTEJx?=
 =?utf-8?B?NGROSmhKYXpSS0MrdUhHeFJmYW9kajFUTWVFR3RsTGt1dVhDSnZsNko3ajNy?=
 =?utf-8?B?Uzl0NXNKMi9lTHNiSFhHaE5yVzBLQ2FrMFVNYXNjN2psY05ST2JPSGRreHBS?=
 =?utf-8?B?K0Z0WmZYMmlXYUFhNFhzQmJtTVo3MjFkMDV5VDNld3pZY1Rtc2hTUnBWNFhx?=
 =?utf-8?B?c1dxNFNOTmR2MTBMUEpqYmpPRGdZOHFjOWt2aGIzVC9VUFMxang0eGU1Z1Fp?=
 =?utf-8?B?VG5HMEVsZEtqWGluMDl1VDZ4U1NQSWZBVDFBK1hrRHFhc1hsYmFXTWMwTEg4?=
 =?utf-8?B?VUdsZHRXT2tUTE9lU1NabCtoWlhpVHhycmZNcmdmUTBzcVVPTDFFRWdwV1BX?=
 =?utf-8?B?em9VUWE0UlNEZ29HVmJFRXJXQWpYdHZ0L2cwdWRMbmY1SWRKTkxXVzZkMjVR?=
 =?utf-8?B?TUtESjVwSUxEUldTWnNFSFBlTmVMdjc2S1RhanNpYUNtQ3BjNlRXY0FwNWZw?=
 =?utf-8?B?YnVQVC9GSFBLQmFPMnphOXRkMFM5T0l0YVo0em9JR2UyUmFwc2tGdWpKUThj?=
 =?utf-8?B?ZmZraDN3TzBxS0g5Vk1FTG9kWXhCS05mMDVrSkZTaGdWWHhTeVMwYjVDelBE?=
 =?utf-8?B?WHcyR3NnRjVveFp6cmpvWGtTUEdkOUg5bS9GUHFKWXZ0K1F1VktpT2ZCSmNl?=
 =?utf-8?B?MFJBdVFtSGRMQk5hc2hSaFlRQmRQa0tBOHR1MmJQakR5VFJkWDVQY0xiMklF?=
 =?utf-8?B?M1EyaHpKQUd3MzZKQnZ2OW9nUy9sK1BMNytHWU91TkdoeXQ2WFhCelk2ZEQz?=
 =?utf-8?B?Ri90ZUgzbkpLWmM1VW5scHB6ZzExOFJ2UDQwWjE3WURLRHJtY3JjeXdvN1Bv?=
 =?utf-8?B?aDhyT2llZUtmOEF5Z29KR2IwNVY1UE1wRldmZTU1RXhLb3V2SzJNNGlyaDgz?=
 =?utf-8?B?T2RXalhybmFZb3pGVzZDZCtibjhxZ1NObVJiZ0lLWE1YNmtsWWZISWF3Tmlq?=
 =?utf-8?B?ZmtoN2dtaVRXMmJ6RndMcDViYWs4VktrZi84cWVSRXhiREVEQXNkK0FncmlL?=
 =?utf-8?B?WVljVGpvQy9SSzQrKzB4aEl6Ymo5Wkt6dWo3dHhXYis0b0hZRUNHZEZEc1N5?=
 =?utf-8?B?YW9NSG9ubzlRZllKWktUYURVa1NCOG9xUWNCZzBMOFNpbHFPUDd1Q2NPNHVm?=
 =?utf-8?Q?k6n3Ue?=
X-Microsoft-Antispam-Message-Info: v4JGytCisiReCmG7sWf9HxCgzYih/eePlJWH2NAzubg4UTWHAOXhdfqkiZUi2xNtFnbcjsFfPBfwLgwDkSsJ855mPN082ZyXPLKe7x4wQx8HKTJ29CS8UjizH5EUhRCSQvhHM1oSijkWfxL8z3yLQ5n2B1NMmdHjXHGql4PZsbWONj/bzQyvFkEwxS3AuWDg
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3605;6:KGyov77Z78wHOfNiw5xDK7pYVe/G1ulnX8pxBuXJam2D+FD9E32V5Tf572R7ncMte3FRyKFvq3gLNTr5owCVlJzWGo27SMw8GtWoFGRvTfFqLAsA6a3HCOpVvVCVfq18DdInkCh3J/jwtgsCvtiJ6or7IGwfmcpDnr+MC8zt0JFrK9DC6Gi4HmmMh0xbELG/d3TcBmdlgUEClaRH17pr0dzVHC/lxkibh7CJI5dnCisPq7uSXDvrbrc1fV4w6XgIc20vLX0ETNeb5tN/vX1vTm1Ee7oHUFX/cjWy0Xuy0S4TGlt3kZdqEurYEDa4UM+hEY/M8s9xdsTyh9aAbW0mkqunnmfsCKUPaiw04XvAC1v5MZ/w49BX2B1D/CR1bO0S+tDXS/zhXwBRxeKrjlhN/zP2jSqGVQeHmCvm80A0VSDCOmqbDOqrCQIbvQRoLQZbMS3SPPp3LyK2YwIXEU8whw==;5:6oPQR9xIgZ6VFHUFRjCuD0M08nmcl+5r3SDPpdlHVj7Igr59/sjEhV+iJCiisBGUUSY20tfodOwWDWMv1xvm2f+zAfVxG5cpjUnK7wPrtbVc0ajSbhJkpkaEhxy4f5j2KwH7pXfKByXIMZCi+7IELo1z7XB3KOhgGviVlCu6kKg=;24:sx4EuYTkj+Uyap8YHeSkoTWroPDtPYypZCZSKnhqC2wD6+YN3oanH9WsqvwC8BFXbcwA/RG3U6HenmSH3fBVDR3QsvOeKelqJBeQFrG+vgY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3605;7:xj3Kj606qGbA6c5rPGV4TcqrFXspAgEBRqQplt1VhuB83hHBoDHjKD/frMA/6jj14h4P/4uaYTG07Vf7zCTuzzJgZhw0sn1766bESI4xdHF6VyfeTeDl5yYI2X5XfLj4Ey8xYkuPVUnmkiorQUxflETArc+EYuw2O/mlsbQ/ta7R04EZ/yqo5q9aC+vrczM79xTS3PIa396jVsw0zP5GUPvN4C0wUEfepWFt6fQ1mcjVgbwRNFeW2a7+/0IxFPhz
X-MS-Office365-Filtering-Correlation-Id: 04386fcd-b37b-401e-b8b5-08d5a3ae6434
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2018 15:26:13.2825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04386fcd-b37b-401e-b8b5-08d5a3ae6434
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3605
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63567
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

On 04/14/2018 01:38 PM, Aaro Koskinen wrote:
> 
> I don't think we should add empty comments just to silence checkpatch...
> 
Well, they will get filled in when CPU hotplug gets put in :). I can
certainly remove them for now.
