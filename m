Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2018 18:47:42 +0200 (CEST)
Received: from mail-dm3nam03on0139.outbound.protection.outlook.com ([104.47.41.139]:12326
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994730AbeHHQrhdTakU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Aug 2018 18:47:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqLWhmXzu1whF/keSnkt/MbF63Zs8wDmO5sO/wWZXjU=;
 b=RJBsyIBZWSbaxmPirqD3Kpz9hxyCOMdoJCXRKVSQHCI5HWNCpye7m+QtRbcXB9IZuNwgMVRbj++P9XkojJNGJzG0g1QX+MSQ5FsqDBYFp1SojvG9DS4VVN4KZ8fIh5277I0nwIxnqCT6E0gA/yaFLnWpOWi6m4zjiVZeo4J3yhI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4931.namprd08.prod.outlook.com (2603:10b6:408:28::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Wed, 8 Aug 2018 16:47:24 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        James Hogan <jhogan@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: netlogic: xlr: Remove erroneous check in nlm_fmn_send()
Date:   Wed,  8 Aug 2018 09:46:41 -0700
Message-Id: <20180808164641.26034-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CY4PR19CA0048.namprd19.prod.outlook.com
 (2603:10b6:903:103::34) To BN7PR08MB4931.namprd08.prod.outlook.com
 (2603:10b6:408:28::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 948746bb-a75c-43a4-015d-08d5fd4e9eb6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4931;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;3:5quspQfoLKjhLttcaIP4GW0L0k/fp/NVcxCKT/2kU7R2M9fZG5Ug5VmijNw2ljzAf8MSyQRfxo6hzXC4yef2kQXuomg3ewCs4+cdloJTdQMotPPRGOmYmU+0FfCwN3L2uMyg5c5bXHA7ypf6htt7SkdWboDzRe2MmyemiBY3WR4lgPYB8l0j5rt4qGBrjUqXkdhRH3vDH6m1yo71pV7OVU1QChR4dk5LoKdC7zF7zYh9B0iJQXEcCh9vuO0Q4mAX;25:2vtu2Ukz6hbVm3UA3vvUMSxu30LhZmfBvZgQH3KqrGENEZBvHnWl9mLVwNBNlyvaiZ2Mg2J7agFFnUJwIvLJIINB885Nd9mEkBrCfCoHgkzO2ZLPWtshazB2zKXvVEHmwUoRn6DUQyDTkrjIU3+AiWVRH4s2bguOVhpa7gBjzqrRMCSETrqqw+LBo8it+DSjzx5jOo0vnteHsTwX0J2Ui1VMbfKd/gKqHNx73H2iG4lynAJpUIAYUe2nnP1gILmdJAndPpyCYowUVtDREVy0jB2J1LR058ikLM1NfdydHg6YikhlQIKZ9a90Y0V4hsLue1iTfXPITnQftH1nK4U2eg==;31:Fksaf/iFJYXPZN1462ejsnEIx+0D9X0PG7SWLjlQ4e8Yef+7L1pKQjiaYQj5RgqkPW1A+GanPKtgMhAF5RuGfNrtwbSzqwouBqphY4dF9plzLbNwhszVxGhv0A8gSBZBvj4p2WTH3LEVux828hRtIUd8YhPqjM+M8dQ4pigo/kb1xBj8hJlgpUTBBqSEz6pRbTyNNkhe7Rof6jmn2mhozcsCMYTFOKNgHJstHZ+aZbY=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4931:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;20:iTdCOmDs1LmjMWcqNMXOiSSKUfxJn6Go0TprdfCzO1fDakd8pvV7ctjXmpTpZCXYYFFtgk/4PEElYXzc5kDEulF0hUaYj1DOptvGgIbTd0HOgA2Gs39OqlPTEcBJx7CmggvtCuT01jKAuwFdbNFLI4Qa5k8YS0Xf21DTHWjYpcyr/C3q6iYIBoEXDwgwJukKitDs3OHnfg+tEmHQkwyw2DSljDVp7MZHI+QXOL3GUAtGcDfxUZXZblApa6Q64fiR;4:sHheRJGbxGJieT1mYo3Y/c0rNH11M9ym079avHEoqJtiobqh6GQ/kztsp4aSqJQsCttgjh9bMnECE9GL8JtoTg4MNZgyzxUDOJXmoMPVfgIF4zEQKfwswadM6Ajhvgf+r2KmqMCA1S2CXSzOpVAOn2Qm9ey/XiRQIhPoNmOf6q4ElfyKlgzL1X7xdrgjiEORpLcbgl/nN0vpFNJbboyO4Y2S9m1H3nNwFsnO4ozzl3bO4eDmpQpK8HVbnca6qvWM0v4Wdr01JA9O+rDQ2uRioifNNkw164h1zCmdJQdKn4rpDQcqqLauWH9gHMpxDVIU
X-Microsoft-Antispam-PRVS: <BN7PR08MB4931B3961CF4D93ADCF6A77CC1260@BN7PR08MB4931.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(208715162771679);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4931;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4931;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39840400004)(366004)(136003)(199004)(189003)(5660300001)(316002)(6666003)(6916009)(68736007)(478600001)(3846002)(6116002)(47776003)(8936002)(66066001)(7736002)(305945005)(4326008)(53936002)(16586007)(1076002)(97736004)(14444005)(25786009)(54906003)(52116002)(186003)(36756003)(1857600001)(53416004)(69596002)(2351001)(6506007)(26005)(51416003)(106356001)(105586002)(42882007)(16526019)(50466002)(486006)(6512007)(2361001)(386003)(48376002)(2906002)(81156014)(956004)(50226002)(476003)(44832011)(2616005)(8676002)(81166006)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4931;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4931;23:sW1P0uAliahXIn5LuruZlT5gAP9o8abRS9RYs0Suf?=
 =?us-ascii?Q?3UtfE4vw+y58vccE0mWGYLXJpxN3b8vWmQ9xVlngNktQmpwXN0919J2oNBMa?=
 =?us-ascii?Q?AL1sCjns+QIO9GfvudNx4LYO+VveLnT8O1cL7/pzycEUw6SxkToIYYC5dAfd?=
 =?us-ascii?Q?ZJOZwwZc9L7t2BlRO8NplOpnr9OSxUb/yEVuWqwIEqT8/E+m20iMosNqsIy/?=
 =?us-ascii?Q?dOOJrpaWoJcLT8H4Y4fkj135o1DH4OhjRFP1bkpkODDlCy0xFvuZNvM+lIKH?=
 =?us-ascii?Q?qt70GhL05nKmPITujZnM0V0D6yz6vZVsUN577CD4AUglFKfaRvJHBlhPnO9R?=
 =?us-ascii?Q?ReAZIxX+bFbjKjk+GF8BiX7CguguPaW3lIyFq1coPCnoV3m32H37eykvOJde?=
 =?us-ascii?Q?H2dtajB7O0/LJCIWQNclpc2JFbYFBSslw+SJQ2f3aSA/fEd6U67caBpOmTci?=
 =?us-ascii?Q?wP/8RPxSVablapcBgrvsTJ6KdDcNvyvSMkjUvQGXk8FW7+V/vUT2j+mpj7v5?=
 =?us-ascii?Q?XHmnj98ZLTmobGYYOGvmL75EkY5vThRB72y091yvrBJDMH45WqiUCNs045+7?=
 =?us-ascii?Q?HGMF5rMK20uXUb5iI1bF1CyZmCTHJDWSQvRSoPpgVQZ9FDbrZKMDS9emoKtV?=
 =?us-ascii?Q?U1d2r4HBgrOSYGVVC2ETbP1OvNkp+uwG8XnpH4YEfJSvh9/J2f3IY+bAspvq?=
 =?us-ascii?Q?yPJtLaNwSasVXlmHVGyNdZM9QajENs7m0Np0lpEJmMWoILnVJ5OxkUtRpSkM?=
 =?us-ascii?Q?BWWPmmpKoh0vWFFi1A9ZB9iR/A5pNo898PD+eOEpyyp27J4lTi23QI5Tm7l9?=
 =?us-ascii?Q?rnYHIM/nae2pcVV919DqCYW8YOpCDy4pNG94UaUCq/yw+5J7URXoYbLqziKu?=
 =?us-ascii?Q?TMATEPqAYWzIcxANon2fTO4Obxn1L3vQR2+1skKhsowRMfy//tC7aAwzoX3D?=
 =?us-ascii?Q?7rGKaMxNrnarfAiIC2hM5/dCSc6kKeFqDJVa7cpaydYVn3en5gJU4vE3DXg7?=
 =?us-ascii?Q?uRFpbSZdkljff1wrDbzHMgvNj+KMqExFRf6C00iEtPHny4Y4IjIHiPG2WHuw?=
 =?us-ascii?Q?azOHIetOxDIo6IhBWm0IMhYwf19Rx8A0NN3CuXtIfRTnecNJfWX8y3HwaE3A?=
 =?us-ascii?Q?jeg8XWWuvgTSwqmhs2TSiPFgez4Qcojk9zw0eNPVfEtiRYlmW53t11C3yOWI?=
 =?us-ascii?Q?9d0omKu1fJoIvDUJH4dkHvpDEL3xiHMTdMoAXDW71aILcOLRBuSFKTFfvTaD?=
 =?us-ascii?Q?l5wMQjejr0NmsGKu8SzdrOMC9BnddQtRX7wy5COQOejIRPYOpQ222p07gLAK?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: zBTHwg2hIEfWTpfXQ7t4TF7Zsh+mZuG37PVCTS0Z7aGKy7PR65CVEKuVKm11zfFYwFEmFrXDzMP091ZH4Z4Vx3O/CNio05YvB3p8YdaU/zCoSI6m3Kcm2VBnrxh+VY7Fa5i6WIcpOQTwmoH7/i6VMysPr90MtNqdCjcQtFyL0weUKnItHcLBVX73Fhw+w895cbq1BHLIKFzLzKTAZ29CVokPbsqghz4zc0O5llEj6RJDGgAtGb9RoTYLulDoBFtgYsZJyAeuNnvaBnVLsuI+O2LSVRPEQFAnB+4y3ceKHT1F1Zsw8PrCXhOfhhQGs+u7lQFi/QvAn3o3XIoiC6vqH4jM53qoMJKKjozTmcv4et0=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;6:3mpcB0G9fnYiCs/K1eCUjliEjgZpSMebLS/qEra31ecrQ9NJECTvg0D7j1oE0YWT5Twl0pMyP6lkEaUkvXUnvSbH9IJjG86Jdya0YgMdei18F5MZFSLEhBctGyHwskJJRU219MXKBGFxTAle++GsM3/DHtZ5iEFAOI37cDC/lZdh3zQM73wso3GbPtIyEJf63t2X5Ct7shu1m+eoz6khrpGv19NUTEiG5rh+upXGPE+cid7jBlO6K0KymrwCI/90cdP0qVQrANz0hBBFlL14R4cBYU0gJQTWODLu1aGeAgXl5VhW1VlZ+5+SBFbepsKi5tHYv4jVb3wzqfQifDsb6rZcDCaYoxWTWG1JD3e75OAsooSPIxd92wNxkFjzFdZA1zi3jkuztILcktSF11+upYgoZkMBHFkCUUI7VvdW5JictY98GiEnKR+C9QC4/b/qWrB6L6LziC/eAqiRxY0NFA==;5:JHK9j0LCLVdqBcDEsKI87owmptzp3dOdznJ8jWsUn8ZR9VHXHcMQkGNuS/wrWU6k4oRmh/hO4RawCsVNYPQGdotfmgt/08WaDGkTPaUjjSxuNByT0jZfUJlQr9aThjKcFhGBqojH5F97JYNaOSUKcWGu8sFILKCEwvPZHARUmdM=;7:zXCLbp60jnANmJbiEmIzgUq/Jyvq5eDOUQjrVoz69hA9J8rElBJI9Jjsul410XKamOW6UAi2brHZa+lzFp/clLemZXIqKJZ7CVSghobkqy6WBr7TlA+rHyRMzY4RiPfoLrYahLiXIF++jkxtRpWUE3dlJsxY92F6a/UE271HAGgSvacJmMsQdlGs1YPXwrvqYHJpkzIJ3teDHO5P75J/XGGCmwyZ5gJ6GF/j71AiMI0wOwGO+5cKA5/mEgSyYzas
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 16:47:24.6828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 948746bb-a75c-43a4-015d-08d5fd4e9eb6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4931
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

In nlm_fmn_send() we have a loop which attempts to send a message
multiple times in order to handle the transient failure condition of a
lack of available credit. When examining the status register to detect
the failure we check for a condition that can never be true, which falls
foul of gcc 8's -Wtautological-compare:

  In file included from arch/mips/netlogic/common/irq.c:65:
  ./arch/mips/include/asm/netlogic/xlr/fmn.h: In function 'nlm_fmn_send':
  ./arch/mips/include/asm/netlogic/xlr/fmn.h:304:22: error: bitwise
    comparison always evaluates to false [-Werror=tautological-compare]
     if ((status & 0x2) == 1)
                        ^~

If the path taken if this condition were true all we do is print a
message to the kernel console. Since failures seem somewhat expected
here (making the console message questionable anyway) and the condition
has clearly never evaluated true we simply remove it, rather than
attempting to fix it to check status correctly.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ganesan Ramalingam <ganesanr@broadcom.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Jayachandran C <jnair@caviumnetworks.com>
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/netlogic/xlr/fmn.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlr/fmn.h b/arch/mips/include/asm/netlogic/xlr/fmn.h
index 5604db3d1836..d79c68fa78d9 100644
--- a/arch/mips/include/asm/netlogic/xlr/fmn.h
+++ b/arch/mips/include/asm/netlogic/xlr/fmn.h
@@ -301,8 +301,6 @@ static inline int nlm_fmn_send(unsigned int size, unsigned int code,
 	for (i = 0; i < 8; i++) {
 		nlm_msgsnd(dest);
 		status = nlm_read_c2_status0();
-		if ((status & 0x2) == 1)
-			pr_info("Send pending fail!\n");
 		if ((status & 0x4) == 0)
 			return 0;
 	}
-- 
2.18.0
