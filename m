Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 20:44:51 +0100 (CET)
Received: from mail-sn1nam02on0057.outbound.protection.outlook.com ([104.47.36.57]:2211
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993168AbcKVToPQX-Ov (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2016 20:44:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kWCJUlDp4Dj4P9Wv3TUu3dG+dggBrNqy9nUvdLGWKH4=;
 b=R1EZ+Z/EEDBrcRuzRtP7bqUjpXNpOS3bQ0Jv6WGclJPQeu6hwm9JeIVq+zYV8LzXdYnnh1xxUopNfLxLGv7zdYIZxudKjeQygL7EGM8HXtIMinQ0I232tXjdcRIdn79ZfqybEZE75YVqqDzfnT2DympP5pQbsi7CzYk5NG5ld6Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 BN6PR07MB3201.namprd07.prod.outlook.com (10.172.105.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.734.8; Tue, 22 Nov 2016 19:44:06 +0000
Subject: [PATCH 2/5] MIPS: Fix vmlinux.64 target for CONFIG_RELOCATABLE
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <6f8e21bd-ca22-5866-83dc-d70e4e10842b@cavium.com>
Date:   Tue, 22 Nov 2016 13:44:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: MWHPR13CA0035.namprd13.prod.outlook.com (10.173.117.149) To
 BN6PR07MB3201.namprd07.prod.outlook.com (10.172.105.147)
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;2:T2yNGDUPjcJ5M8YZCHoxNGPUrzeRg+HtWE4mQCMQdaYdNnl3O8OqVe9w2WUJKwTNA0pVSJSdzaEg02XREK6o3KqoDwoRh/EKAIZMGDtAIKSBZ9kSqSvtg8ni8N1fHSb1jwLRdb2QLwcqxiVG/XRDwHEq+uHJgNJlWYSIXJAdOs0=;3:TgmvrAm7NUjzf4rPrRLIt+bsHZfOweQwPAD1cn4mf3axJ2c/cda8GxjLmpK8lYEPtPVNfTEU/kXjtI1RBgZr/zo6HpVa+gei1hFVegEVlg+8jXAcrh5rSq9wUQDziBjGA155UM6w3+J5vd3gQr/TYPQl0qYU989BNy3Wgp9yrF8=;25:nrZ8L/N5674w/80y2hs/GvZSlqRlZbzJ3NS9UxkiLMbVjP56t0lueKF4GE6FsVApski8VmO/PVD8dXrVQZIaTHQhE+WaB/pget+oIOaTttSU1E7uxg0yDP0CXxbXoGdcOek16DHqbD7JlxAvTCW/1M/Eq162+taRThdjlXiJKxH+UEgZNDAyyny58WBmV9HWJIfWEaZYcwTzMRBfP5iiJJiCfWNVBahf58LcxYH9MJTCVvmWrYNk7HWxYmsUDfwjt+QbaVg6RmMkqRBx6pDGCbFsSl8srGjYNhlv/EB5kkcfXUxBaWxjOIpub3fNyA/vEJ8bwAcxVPgqRnm5PjM04ZCqwSLqKKYsHH+0bU63bajOzVxB7FKpD1C7gBd+Oyu2bhvqLzKfmIHzeEPT0yHvvbNwADqoWfzOBhD7bD1Grq5mIEhkyaAHVsQdCeyD8yvufaGls5cpVtOBhAIF/1oWww==
X-MS-Office365-Filtering-Correlation-Id: ed6954d5-5e97-44c9-dcf0-08d4130fec31
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BN6PR07MB3201;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;31:BoBGyvZxonteVHiX7Qb6wBIsYjS2D9RQlQMrp3Oc4QdZayTxOPpHwD+hKglNL+zF6aNzFMJCHQfSAYz9UQXO7jvlLD77WsOO72+NIONwm9oEQgr1qAvkgkF6u4GXhNd0+4USbUiMQlxS7m/UhQc7JgDX9PFVe9diXsNyzuwiW7hN9P0re1rG6TfmvSQ3YHd4B0MOcirNB07vJfXkQISXh2eJjE1Mz3++G68RvQJE6Uja8AL80ZeRcc3eFh0ie2blzvX8HKPF8PSPx2h+I/4lHw==;20:0vyGJ9A0mASr2k6088NVIattVD7mNSaljdtzUZ8baq7X0smiggnXgf8MhpMIH1YyJuIPuT1btbh7BCpgfqwwuziBGA8NyQJnXP8O3l+SjFE/J2Py4eNCWbZ0bam3Js1IHPY8ZCFnsVQiIRN7MEy25PDWqRkts69X++/yHt5z2ZpW9glHE4v8GQI6ENQPBXOreNhJZFathI05cuAvHam/dr9/MZ/ANWLtnsmmYdk4UkABXhlDMahZcotHa0o+zQDqlcD4rZG0h0Q/XhvlpHPNGRMOMK3oJaPX4RYw06zoRQkMc2OIim7hzeHj4GH4xBM62C4+qVlkXprjO+IGQIT5t48Ty7RgS1zLYjrXMES/n74QtylS9Jgefku4gUvmg0ALgSaS3sQzli30VW/tSpBj7rGB37dZUJoCKWMjq2hRwTc8yPH9ayxgYJL6O0dwXdIl7M5kK1znZ1QuA0hgvnZV60IuF8zWRHXSfGcFd9P+Gt8iKINXls+FhgTtpqTQ8yi9
X-Microsoft-Antispam-PRVS: <BN6PR07MB32018345DD82537D1C241BB180B40@BN6PR07MB3201.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6045199)(6040307)(6060326)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(6061324)(6042181)(6072148);SRVR:BN6PR07MB3201;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3201;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;4:kg54YGS7j/5eBibhDLzVvet6RPiVuIVRKK+5AtVW4s2wxfcvJGuqQP80fOBRlXnqPAno+6hbLhuxjdo/VoTEoXAszajL9ip/6PE/Y1dqdRHmcRnkupoif1h5Z07vIm8jE+Mj/Q7QutjvBMVrdJF/qwjgAS7EsmDkIg6nhEBlA16AM3aFvwdUfjrfTuXL8Yu+VwwAhjpqfxQ6mfTQHEPDwmyFczo4nMmE4anuj2/2Ccqlaf+RM2MXV5OWGifxqrGRzDSRgHrsf/FoKZs3O3Bo3dq+MYuMHVECezc0x5z68L5Ud51xzaNlvNTXHWZL37ibCtlBfgXe7m9B2lZGGn45ots1XI3HCvv/DXe+N6cQLAkYozIWt/kqVkiLjvZqqqADBtYnWMUBmqNudtYoYSPakbnwI9c/ia0po5IPyT5LaBknYE7R+CSu2Qmy7Pwq2nr6VCMMljteM7+y4whOAqg3bWsIoVH/IZW8Lqc7OUCy09/qbxovtY0mDrpG2/CTlV6C2pHZSraFtxaPq8JF4MQVbg==
X-Forefront-PRVS: 0134AD334F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(979002)(6009001)(6049001)(7916002)(199003)(189002)(5660300001)(65826007)(2906002)(33646002)(36756003)(2351001)(7736002)(83506001)(7846002)(86362001)(230700001)(81166006)(92566002)(305945005)(66066001)(65956001)(65806001)(81156014)(47776003)(77096005)(8676002)(6666003)(189998001)(97736004)(4001350100001)(101416001)(106356001)(6916009)(450100001)(31696002)(105586002)(38730400001)(110136003)(50466002)(23676002)(3846002)(50986999)(6116002)(64126003)(68736007)(54356999)(42186005)(31686004)(4326007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3201;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzMjAxOzIzOmhXcWtpTlR5ZHNqQTloeTFYallBY1BnMGtK?=
 =?utf-8?B?ZXRZQXpuak5TOVhUZWJvRDFzcUpmVVFtQlhlWjM3MXh5SGd5M3R3THRNRWJJ?=
 =?utf-8?B?VytTQmlubi8vdFBBaHFVRGdhV2IxVnJmRWxxc2hwN2p2a0FXK0ozV0VoWG5H?=
 =?utf-8?B?UzVsV1ptUkhQVk5wTWQ3cklNaGFWS3owc0JNL2hvTnI4eDlrS0JNY1U4d1NW?=
 =?utf-8?B?NnEwV2dtSjhGQVBMdEdra2xHQ2VJR3VpMUhpWnZENFhOWXFtMXZQMFV3UnZw?=
 =?utf-8?B?YVlSRXAvS3VvZXFpdkptMzVjTjluVG02bEZpWjNVVzJTekNxb1hHa1gvZG1k?=
 =?utf-8?B?bG5WWDFLbEZ6UEN5dUk1NlFTczZkdHJDcDVReXlXYmhFMUtnVFE4S09PdlQ1?=
 =?utf-8?B?R3l0WnU2Ym5LYWVHVWxjWWp0VG13VFIwZ21lRmh0MnpwWGRxdk81bkk1Zld6?=
 =?utf-8?B?eVdaYUR5eEpJSVdQZkp5UGE5US9WZWRCbWMzSVJhbVpPQVg3WjljLzRRY2Qy?=
 =?utf-8?B?MmxMZGFmVFdSTkNHZXFnMGlteWxoSFNmeDBwTnM4ZEYzVEtEL2ZsN1hudUVK?=
 =?utf-8?B?YjM1Qi95T3Q0Zk95TkZSeDhLZnFSMitMZ0RIeGovMmE3Yng1Y0ladm5EZ1hO?=
 =?utf-8?B?L2RjeVJ2UnVVTTEzbUkvNFJKT0FnV1FpOVN3KzdYOXhuMUFkUmdiUHdLcW40?=
 =?utf-8?B?aUI2Rzd3NmFacjRJRGR0djBrZGllVGRVbUw5dVNuVWllcWgwWnlhQk9pVnR4?=
 =?utf-8?B?Yy9OUTVlODhrSE9jeDQvUm1mSFViS0VzbHlDU2Jia1RKTkR3aUJiNWNtTmFj?=
 =?utf-8?B?dzZmUnVVVkROSU9zU0hpTVo5RGx3THJIR0xTWmt1em0rTUY4dUJqRmNCUlV2?=
 =?utf-8?B?MXlTci9KT0E5SjZIZERHUXoyZzBJQ29JN3hzR1dLSVl3SU11WStueGRHL0lV?=
 =?utf-8?B?MkhmT2FxU1cxdUZZQWNxTUZTb2RndjZ1aTFxZXl2WGNnb1RQa1BHeGYyNTd4?=
 =?utf-8?B?SHdzYXVxbE5mUDI4QU5vWTk2bDEwVXJYT3lnMUU5cUtuUzh1MjY1THYwM1E2?=
 =?utf-8?B?S0c2U00rSVBEcnVIWGQ4RlBqWFhMUmNvWmlNeXlveVI1bVU1VzdJbG94ZXRW?=
 =?utf-8?B?UlpHWTNvT3VHOXZkMGVzTnZhK1A3WkpscWFsWDJGNnVod1VWcFFpUXMzT3FX?=
 =?utf-8?B?ZTFzUDV3aEhqNmVzeDRUbitJY0l2VHNSYTZXUHZLUGZJai9Ld1ZCc0dJVlZM?=
 =?utf-8?B?ODV3Uzl0SW8zQ1RUaG1aSGhsQmo2UWg3RFlqc3piWVFZQnpod2JJK002WHQ5?=
 =?utf-8?B?SGpCTmx3cnV4Z3JxMHV0Sjl6VFNMOHpTZDJZSTZxZUtuaGp1UG80ZVBVRFZ2?=
 =?utf-8?B?M3V2MEpwTXRKd1lwRkl2dzJkSS9XKzVJcTlvMElnYWRXZnp0WkxTdFdXLzFF?=
 =?utf-8?B?THV5TUVGN1dwQmZFYTB5THVJakQ2VGF4VUE3WmVyL2RPQWJiang2MUlBQmY1?=
 =?utf-8?B?VTk5YzVyelJxaG55anBIZUdLNHAyclgxTGJudEJBbmg5cVBXSjVYcEhGTS9k?=
 =?utf-8?B?S0VLRG9sbjRxaEt5NjhlL2lIOVVKUzdQcHEwczhlcmhxRmxKRmYrUXJiNmJB?=
 =?utf-8?B?ZlhlSUpaSFNZR3J0cU1CdTdKZUpEUWxyR09JVWk4RUZtR3hXMXNNbHI5RGZN?=
 =?utf-8?B?ZmN6MVlYTDZVWmFiRndJUW9tWUNCRTZKbWVMYThKWks2RkFVSCswT0NiNTBV?=
 =?utf-8?B?T3R6MUhHT3huYzFBS05SUkFJYVYyNkV0MHpPcVZFRlloNVZsak14WlRJd1Zi?=
 =?utf-8?Q?8Xy5OK3icIYwU?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;6:Wxr880GkESdYeOQl4IVdyIQ49JdIzRJz0WvTYKVQhmLose+BrSpFqNrZ+FQ/EOOQaV22S5WuNikaJrzBOr7mfXFaCL83U3qjfECG04oXs9N/qiWGgU7PhHXwOAjmHOF5fv+Fj1GXHlsi3o2D/LdlHaZ0G18q9SwCdrrflRs7XbUxcjbqp5NF9+Zg+hZn4GU7HMOmWKUE+BVw7NemBBCiEZvJoXpBC+TPwBR9PuBNV+mV6VgkDprgV2lP6khh9DKlXTFLtIjMafqpkr8usSJUkGs8KJiSM11l/dOJD3iIm73lEemdm4gze3SzSjW+A50GYv4IeuCAt8IKcmVPsSPwyhbaJnLkDtuIf92MIGhAFDg=;5:lVr5WDxzB7qAVD53uwHl2CxBVPmbsiMsoPfxBo/6tLEYSst9DkMKAdee+SERjLCjj/iJysAowTRlpTJnSw9DAnlzSRS78fi2YkZcJHm7s5J/HvXF6BGWQLcZAXnvCyvM/P7fu+okIwkD512dimei/w==;24:/QFGICCRknHks8WbePpic8UENlm7p7kT5NQ2Cmfa5lCYeNOukT3k8aaB+4WtllFoDP83GnxjasX/gP52QkDivJXb20CmlH8TQZV8k7JZjsw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;7:nQ1aVfet94jDKMWhuVsfPCe4oVyQa/0UuDnR1GKoY3guldPS2FFIqVINcE+aTp+qd/jv4qtV2HaWjIrtK1+g2r+g4LIDe84P+qGsebrKrUbTP/yS8pVoyGnJJAkXnZJ+hYfmElttgXzXhwpL9DBSNIsyeTRk6Fv9niQasNkoGVeWaKn6NFGD8LtXHXZv1rqYDwEwH8JM+vt/r4COajRM93CKCVDWcoDsrT1uIoZYDOScOxIOKeYBPQKLvFviCj+nYytwxf03FFXHaIEjm7OCDFIPVlXICcSSEkznf9TMUIHiVjsoC1vDp0Aj3LP7tmHEH2xbbv9rEGRF7qjXfvF9goJFUOJhWRf6UoCzo0b9biU=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2016 19:44:06.7875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3201
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55856
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

The vmlinux.64 target was broken when building a relocatable
kernel. Fix calling of the correct tool.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 1a6bac7..61568df 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -353,6 +353,11 @@ endif
 quiet_cmd_64 = OBJCOPY $@
 	cmd_64 = $(OBJCOPY) -O $(64bit-bfd) $(OBJCOPYFLAGS) $< $@
 vmlinux.64: vmlinux
+ifeq ($(CONFIG_RELOCATABLE)$(CONFIG_64BIT),yy)
+# Currently, objcopy fails to handle the relocations in the elf64
+# So the relocs tool must be run here to remove them first
+	$(call cmd,relocs)
+endif
 	$(call cmd,64)

 all:	$(all-y)
-- 
1.9.1
