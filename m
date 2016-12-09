Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 10:35:55 +0100 (CET)
Received: from mail-bl2nam02on0055.outbound.protection.outlook.com ([104.47.38.55]:46336
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992244AbcLIJfsdz7Zt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2016 10:35:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nlmKjxq5DyEOLeSWRGt65y3JuOrQLL2WRLF3W2PLG98=;
 b=fYSSndgT8Nit2/Ki9fL2kAnKuvoZF5pS0DSOiYQXgiOzvhDlgoeR6iT/nwAZrfgTV5DWoo7m8jT9zrzZwLm3RVP/C9vqSUrC9lp10kSOMatDOr04SjKyP2iBjJEO13QeBBVX58YAp4qnHmXzw8yUbVXnC5DccmP55aSQjMhn5TY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.761.9; Fri, 9 Dec 2016 09:35:40 +0000
Subject: [PATCH] MIPS: OCTEON: Enable KASLR
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <4bc97883-39b4-1a00-6e06-518c598bbf3c@cavium.com>
Date:   Fri, 9 Dec 2016 03:35:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: BN6PR16CA0031.namprd16.prod.outlook.com (10.172.26.17) To
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148)
X-MS-Office365-Filtering-Correlation-Id: b5927bab-0652-4479-be97-08d42016bd9c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;3:wSPH/q5l64rbP+rGwCog7ZFDNYJz6OLQhoSmGuYqrf1/6rkptmGFaSWSogWj2Zx6G4CizBy7AHYbkPBCvidR/4erGXAVQ5gVGvdvvOnShnqv448XxEPBhuPjjy3BNPJ8fTThMRKYtwVaCdKoS8819gJI4lciQf1hl2tB4sH5n0gwZ3f2uqvpgOCK0hbrIAxzoF115DiE4kYjWiDUpq32EgKuCjeCO+ROgp0GwBjiX+rq5v1v7tzfpxNj/7kuhPkhTJbnb4osMQ9kl6FCQxwNlQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;25:NUxskehnqe1/4gcsXegHaXC8gLWZ/8kDgMktoYoVfrET58h1zdohqxy97Vmf9iAFyyB81ZcZld9/9sxNR7zi2OJTeBEPLMyKK/my1vS4htAj5Ul5mVCXHTEWDqBv1N1RWPK9qZUdGN5idFbw7/EDi1x8Y6ClLjQeDwL3dlAr6RZsxP+m+r+Qm1Td+10YYPG/NDjMt8Np26SZfoKbxCIX+TOSwD6MaEQhtx1TZUEq+NPxNbnw26elxQNccgd7xsn3nZdesnE9qaswPNEfWWDGApGmYshqg69V1whFfFprhuI7XzCF4R+p9zFeCs/zEsWeIsFzjDVMZSjtu97TBbjrG9J/BS7sceQ7Ef+6zt8DEauvZjzM7bzN04oMtNEYGgldIFlJfOScNCjG2lDZv+8TlZFQWHeylLyKQoMkAxdQyT+5OV2ioTT5t6l4o8s/YZA90JxhBUSXyi5Mv3MYguTeXQBYmj+BbbH+z+VjY8VnReI/vl+GHkmVuuaWGfMKgMpHcnhiFr2rSP1JO9YHS3paTFvMzOwxH3z11Zi/oVPXt6q5Cl93aZb7RRAsTxAwgujOjliZ5XssTVgXdbHPN7lbuWpZXZtVjQF6jCY5oOp/0SOhyC+etV4CS/5u3XQuLCFI/Q4b6YsKX8+PKyR78EkOhrmGvYJ/pdkT1axagbq82v676XpDyKSrwRCtRXyKzzVQ7ml7H1472JxjK71fvmyTTs6HMJNoxANIOOzbBiTTHlV0atHkeOAbT9awkEEuww46
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;31:CzzLYtdglHHdTiWD2Ga05UJpMCz3wPv38CdA+ONR5yoGnPrJjTr0yM+JAh0pGpIy/aaL5RAQYXl660gMCa6j0dkTBHS1E1mZ3d1i2nvYvsb0HR0Brye+PjI+e9VY+20DMXNpH+H0WkKoL0B5dSXGm4xj5sMIhhL4OHb9QYlGZosFWCO1kzhCNUBL8kEY9VI7jcMkOvCL1nU0c88ley06V6D37r8N04SqYlM5NE4FFOpK4LWsEno7P3FkQzHNSViJVJG+8OngWLOyBe64udRpzw==;20:IXO/urRi3UnYjuaKs5Uf12Hd3EslRedsF7NxBmvz6vh3emPyPnWezNHx5gZ1m7MNO4RNI6jRQsUzDctxElBE5WTQ/O77IJhihySl+5pwx64gK7n/qdWRJqwCHfq7LloDcsD0iei3gg5APuB8t8GEBWo5reKzxMe9HNFQCAt80JMHiH827YylN4KLCxTLawt2ZoZWtMn6lpSjYCHmIdDHkfK2xnfT8bY3WkGzEqhU/+oLTuhjDWuvMr+nr/IBSPnTXipSpGacgbkhA30kB4PS/lw9eNSS8gmahE+JMFnMdS/yAwJT8jExpxUhdwn+W0TG7EQj8uQ0bNWR/janbdEPPANrhNUYkstfavHFP+SfghbKgDCPHI3ZMkP9sUro0PLrR/tTSnRiJnQ0El3NWpF35ryql0KdY6npeJeF7Wd24OMpBSlyHbbuLWxxhD+JRgn4zlvi/PvzMWxiyI3L6vXF/xhYKZyErCB6tVEhq3ZFICaHpDsEuhXboN+WBDMclWdr
X-Microsoft-Antispam-PRVS: <CY4PR07MB3206AC8A9DC819759B97022C80870@CY4PR07MB3206.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123564025)(20161123560025)(20161123562025)(20161123555025)(6072148);SRVR:CY4PR07MB3206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;4:u+FzaIYcOm1Rba5WOon2IkA2DsCXKCaa5HyU+7n7vQLe5Bb5yYUEEF7+YFVG7cg5PfkJKFkhLJ4ZC7UDB26aHAIVL89ewuIRXtbNT7F+sTaDS366qH0lJ6sXub7kGOop4EZJ0nHYIm1SsuSpERAE7qxsR/R7akp28uq0n3pM6FDN/OPvsO43zB9pbL0dhWS2RNeX3a2vwe9s/s3SFqdVC1slz+QtJneB1mchzEiO8/s9Mbqc33vUtzH+Ciup3gP6eJ73V0duf3irx+d6r714fQa5Znoi2j4URvBqSvh/qZMpCKjAoEg4S3UQX9LqyD9z24QSYThrf4aYg+ECcYsIPXFC1t0MfjBGN6Yq5kL93u8fukdcyqOi6PJFk1tqiYhDKyM3HLTnNHjtKrD0qyoCI/kVqucX7evYCMIu1Xx3BdvUoBl65t11yx5SDeYvrkW2H6R2etku+yyRZsDU75KZGoK+OMGfwysI97zB1Y2MlxIrwzhhOoU3/myRuUxLMoQxcMe5ZIOfYTUugE8tFvrhJCOnpXwXuv2d2ghe3dYMc5q3XsXQaBQ1nf0713GEYtXV
X-Forefront-PRVS: 015114592F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(39410400002)(39450400003)(39850400002)(39840400002)(189002)(199003)(105586002)(305945005)(6486002)(36756003)(77096006)(106356001)(733004)(3846002)(6116002)(92566002)(50466002)(6916009)(6666003)(97736004)(31686004)(83506001)(4001350100001)(2351001)(33646002)(8676002)(4326007)(23676002)(64126003)(230700001)(189998001)(42186005)(54356999)(50986999)(47776003)(7736002)(65826007)(65956001)(2906002)(65806001)(86362001)(450100001)(81156014)(66066001)(5660300001)(68736007)(101416001)(38730400001)(90366009)(31696002)(110136003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3206;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMjA2OzIzOmxTNjErZVBDTVZwc3hpaDg3QTM5eVZ3YVdF?=
 =?utf-8?B?VGJQclh6MkdOUzU3TnBQNEF0THUrOEVUS0Q4QjJmRzJkMi9PY0VCalVHT2RX?=
 =?utf-8?B?MWFIR0VWNVZSQ0FhNFJ6SDBZSlptdHBNUTU1dHcvSGV1eU92TGtlYkF3QlM3?=
 =?utf-8?B?L05oS3Yvc291Y0pZRjZMVUNINVZ2VmRvMzl3NXoyNnhaV0t4MTVvUXVmSWNx?=
 =?utf-8?B?RzdKYnFpcFJrOTIwWnFZR3JMWkt6WlZkcWJmQkpldFd1WkZ1RFBMaTduQ0Iv?=
 =?utf-8?B?SytNM01vY0NudlNoYXVkQ3c0bVkrd2ZUbjZBZHRxQmxmMU1wdlhuMFlzRm1M?=
 =?utf-8?B?U3NTTW9GTHdweDJNZXQ5dHhpV1dsYVBENVAwQXhZMjZkWmp0RldsSXZNSGFM?=
 =?utf-8?B?RlQ4NS9wN0MwVGtKNjdiL2J1ZTFLNnNSMTJKYlJMQkt2QnV6QVNHbjdBRVZ4?=
 =?utf-8?B?K3o3MVh4MzVSY2I5YUFnTGo0OTVYaUdxYS9KbWx0Y1FIcmpWZ21LUlNsdlEz?=
 =?utf-8?B?NHpYSmxhZ3hZN1IzWTBTS3F5VHlXM0wzRlo2K25VUGdGamw0MEhpS1l6TDJq?=
 =?utf-8?B?bkUwMC9jVUtyZVJUNUtIMGZFSU1uanpPZDM1YmFZODJGYXNiWmpQLzNvWWRF?=
 =?utf-8?B?TnAvOXNXeGphTEhZcVZlcXBDQVpmRG54MWVubVUxQ05PR0xJanV1NkhoMjYr?=
 =?utf-8?B?V2ZNR0pkdDNKdGFwUi9wcjNXRGZUSStRdmRDRHZ4dGhNNmF1WXZsTlJpa1k5?=
 =?utf-8?B?b2IwN3hBWTYvS1JHcGczblpZV2JubzA0bTlkdmljeE1ZUEpkRkw4RWtPZXhm?=
 =?utf-8?B?Z0QwQjBiR05PMm02VVhxbW9RK1A4TGtVS2hSQ2dsK1JXc0ZNcjdGWGZ1SE9D?=
 =?utf-8?B?bnpJVjV3SjNFdWVVeUlNYW9EdFBPS2MzbGcyUkNTYW5LMDA1eVozMktyNDlW?=
 =?utf-8?B?c2dML0U5TkMrbGhZckF6Si9tOWpXSUM0cWhSamdEVDMzMlBOKzJVNUpFSzRm?=
 =?utf-8?B?THd1akxjWEI1MlhhTXdleUlxdnNRVk1uUkFsTE5qdk5PMFFtNHlROStoNHN4?=
 =?utf-8?B?blFoSWczM1IzSnhXZysyZUpLZW5Bd3hqaDBHNzlQdFY3c211VUQ4djNIYmk3?=
 =?utf-8?B?eFRuZE9TS3ZLQUl5MUlRb2RvK1h4Q0pFcWdjUzB1NTN1blhacU9PeUdKSWxP?=
 =?utf-8?B?OE1uSWFXREdiRStXRTUwcTVGWG93RjNZNm15QmtUdlN4YnFhVmhWWUZQNGdM?=
 =?utf-8?B?bEVzOU5EczNpQ2FONkpaSCt0TTlxQis4VXVxQkRKcVFjT3hrUkxMZGpUSlE2?=
 =?utf-8?B?V2lOMEQyeFlud3FuMGFNMFpGSll5VW1MTGgxSUxOaFhTQ3M4TW5IRGU5MWYv?=
 =?utf-8?B?TnFIR25pMjk5S3VZNmZuRmt3d3JtRHowdWQ1cjRHaHYyUjFMWkZaZVdxaDFh?=
 =?utf-8?B?ck5jWFJwb2lqTFpORmh5WUc2SHBaVlFqNEJybUNLU1lzd3VYVUZKcks4TDVh?=
 =?utf-8?B?SjlJZ1lQRDg3WTRHWXIyZGdFejNsNHBXUWkxamptUWNBY3gyRFpqQmRpZ0Jj?=
 =?utf-8?B?VkQwNVZlYWRpYkUrVStzYkpZVlRFenhld1l3MGU1QjNMaExmTHRxVkNmbmpJ?=
 =?utf-8?B?VmxVd25IM2hia1V6Y2VqeFF3THBZc2FkUmdXd2QwY1h3aHEzUkxxVnJVRGxY?=
 =?utf-8?B?L3F6S0NZeFdrRy8xcHlCUEJraFBWa05sNWQxcDJISGdGZS9iS0ROOE5mb3Nm?=
 =?utf-8?B?TndCUmE0MGZoL3NtaHl5bEQwK215V2RIRTh4TWJpUmtPQUpKckIzbjJxRkYw?=
 =?utf-8?Q?wK0tKkmRYzv52?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;6:OlIVxLLYdZR5/Os2mA3xSJybInoqrrOuzhFPI1UaNall/D2NtdNC2XxOQAZLtJ7MZRmt1x+YYUEINUFjNw4ZPCJIT4Q43YjkR5vfbUs6QqYXGDpaGra//urXgIybCblfdtjW+G3YzGPgXt9oD94P7vEyqfPRTSWwm+8x3MeNK+F/eQsw749dw5I6neFDbVKBAFzpS5WKJX/9Di4YNqEv5zL5y6C68FcJphaYr66EtWgxQNGUMSSnbm6MJwZxEQgYDd+iztT8ss5VnrBS2KYTofTZMjhsTYx06DQZpuDEoiJdIqUU8wNt+HpMZIsDMWubNOqr++lrDhS+AXGc5aVxxX5vTNtCi0JH+ImH7Vg2VqceOU1e1yEhU7RBLhyO2ijP0I1der+4jYgBNx1r9go9vv4Q+yavlDo40RhpAd7m8qA=;5:L3Fl3kjjAfK+7CqbSJLU6rSJ0c50se7wzroGhATJQlGYgXFoup+Kac+wANQccbZVGR+dgJplgxoQJS2amXKs8n8kTL9Hmw3ZHH9Q+sNdogmEsymlT80OcVmHdBM9Qd/gJDiR2ZWe92U3ii775+WfSQ==;24:6MiLGpu5tuBfGF3HYT87Z+g5qJD5gVVprwn6MymCjW+py9IZWY2TZ184vdeG4DVuxyudWA06soWfj32mWHKm+ZhXeu+Eb2iVXIeU4AEwokk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;7:mNz7e+3xUK7heEqvxZ03HZD7If40zRvbhGVV0km2DCbDB9Y979N4hdVN8ZnDMLo5Vjj3eq6/Wmp34xLSnAP+8Au8cQ+tWF8eWCi9yJ5BQ7qm92dNxYhi6dEDLwRBfB4BZ+acjQ25QZDOxRcmKCPDZ3e2U7Et7WGQJYl15iD7Df7QRNY54+A0ijdRxCJ8OwMNz4u4QCgwgktKg/x8d15FUenSCquQmd+ZIv89E4CMMZ/V3G62LK1Kp3oZiiasLpTOsRr7UBA8q3voON6zhZYQ92VuklRW0b/bweFpRyvbE1FpnmRO89LTrz51lPbh5KwO5wQW986/kkh80MwXY7udofuhFgv4ivuKBljgtFyRLtUTQtCCvrRmy7tyuwxq0Fh/vEMVmEqtVkwir0gGaoHoK02GNPQ3dB3ap+PdZXxkskePFYcL8mNk4DWmuW/lf17dUkd7XRibF2+Da7gTUCaAJg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2016 09:35:40.3734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3206
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55987
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

This patch enables KASLR for OCTEON systems. The SMP startup code is
such that the secondaries monitor the volatile variable
'octeon_processor_relocated_kernel_entry' for any non-zero value.
The 'plat_post_relocation hook' is used to set that value to the
kernel entry point of the relocated kernel. The secondary CPUs will
then jumps to the new kernel, perform their initialization again
and begin waiting for the boot CPU to start them via the relocated
loop 'octeon_spin_wait_boot'. Inspired by Steven's code from Cavium.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/Kconfig                                         |  3 ++-
 arch/mips/cavium-octeon/smp.c                             |  7 +++++--
 .../include/asm/mach-cavium-octeon/kernel-entry-init.h    | 15 ++++++++++++++-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde..65d7e20 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -909,6 +909,7 @@ config CAVIUM_OCTEON_SOC
 	select NR_CPUS_DEFAULT_16
 	select BUILTIN_DTB
 	select MTD_COMPLEX_MAPPINGS
+	select SYS_SUPPORTS_RELOCATABLE
 	help
 	  This option supports all of the Octeon reference boards from Cavium
 	  Networks. It builds a kernel that dynamically determines the Octeon
@@ -2570,7 +2571,7 @@ config SYS_SUPPORTS_NUMA

 config RELOCATABLE
 	bool "Relocatable kernel"
-	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6)
+	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6 || CAVIUM_OCTEON_SOC)
 	help
 	  This builds a kernel image that retains relocation information
 	  so it can be loaded someplace besides the default 1MB.
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 256fe6f..65c8369 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -24,12 +24,17 @@
 volatile unsigned long octeon_processor_boot = 0xff;
 volatile unsigned long octeon_processor_sp;
 volatile unsigned long octeon_processor_gp;
+#ifdef CONFIG_RELOCATABLE
+volatile unsigned long octeon_processor_relocated_kernel_entry;
+#endif /* CONFIG_RELOCATABLE */

 #ifdef CONFIG_HOTPLUG_CPU
 uint64_t octeon_bootloader_entry_addr;
 EXPORT_SYMBOL(octeon_bootloader_entry_addr);
 #endif

+extern void kernel_entry(unsigned long arg1, ...);
+
 static void octeon_icache_flush(void)
 {
 	asm volatile ("synci 0($0)\n");
@@ -333,8 +338,6 @@ void play_dead(void)
 		;
 }

-extern void kernel_entry(unsigned long arg1, ...);
-
 static void start_after_reset(void)
 {
 	kernel_entry(0, 0, 0);	/* set a2 = 0 for secondary core */
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index c4873e8..f69611c 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -99,9 +99,22 @@
 	# to begin
 	#

+octeon_spin_wait_boot:
+#ifdef CONFIG_RELOCATABLE
+	PTR_LA	t0, octeon_processor_relocated_kernel_entry
+	LONG_L	t0, (t0)
+	beq	zero, t0, 1f
+
+	/* If kernel has been relocated, jump to it's new entry point */
+	move	a0, zero
+	move	a1, zero
+	move	a2, zero
+	jr	t0
+1:
+#endif /* CONFIG_RELOCATABLE */
+
 	# This is the variable where the next core to boot os stored
 	PTR_LA	t0, octeon_processor_boot
-octeon_spin_wait_boot:
 	# Get the core id of the next to be booted
 	LONG_L	t1, (t0)
 	# Keep looping if it isn't me
-- 
1.9.1
