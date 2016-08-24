Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2016 18:42:24 +0200 (CEST)
Received: from mail-by2nam01on0041.outbound.protection.outlook.com ([104.47.34.41]:53022
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992160AbcHXQmPXRTFO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Aug 2016 18:42:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5nd4KSwvUqXCP7Kpm9Exbq09TIxcqXH9forlvf8CZL8=;
 b=gAF9olL40k/v45vZ7glYr/dwAjTq9FkHnnQIKndiPYJwUPEhg/lfdHcgZzW15roz7N8eUxhFvCvRw7oi/FH41HNX27PeoGD+0GJ3wNojYcXSU411uSyu5iPu5j2AH46ocVr8JTfBqfoBOR/q/Zy2is/wFECbZhnyHb12dAanzDM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 BY1PR0701MB1093.namprd07.prod.outlook.com (10.160.104.156) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384)
 id 15.1.557.21; Wed, 24 Aug 2016 16:42:05 +0000
Subject: Re: [BISECTED REGRESSION] v4.8-rc: gpio-leds broken on OCTEON
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Daney <ddaney@caviumnetworks.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>
References: <20160823203605.GA12169@raspberrypi.musicnaut.iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <57BDCE58.20200@cavium.com>
Date:   Wed, 24 Aug 2016 11:42:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160823203605.GA12169@raspberrypi.musicnaut.iki.fi>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: CO1PR16CA0037.namprd16.prod.outlook.com (10.166.27.47) To
 BY1PR0701MB1093.namprd07.prod.outlook.com (10.160.104.156)
X-MS-Office365-Filtering-Correlation-Id: 9b4eb7b4-0100-4be5-355c-08d3cc3d95b7
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1093;2:AKYAsXw/lQfcnXarN/XNE4oRmgu1aJOkf+L4syxpL0Y2RH3UMucD7xKbpLUCjt7fLGogm1qhaMRQymrY0RHYYbuuJIX1EokZVqdlDJMmTZ7Y4/Yf7b9iWuh1y2hZjSiZ3Pe9tHRhYwoc8G8bYH5VjaPSRv3/A4aTbpqwSwqYo0Khjum5NemF36FWkjlrJ3hK;3:TTpF/VyizFyyIZLxTYUXqplMtseHJ8LmLGkxqnNdt/QvMXX4dQoIae+QND8DoJ7ofzXBVmMf02Q3Bh7HJWb1tmqvSFBy3UljGE8saq6FTHBUdinhEv6VjOM6UcyTkH+B
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1093;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1093;25:/YsJDOLv7GNEBLMV3JTSbNuJZGiGmrkIqCraS+VEsbatjFk6jncWuyTA3DuHzZLm0IJsOT6FuUPqaz322D03dYjzvj2YKmqFqb3zJeH+VrwRrREfvJ8Y7+/UaXtYhpGQIFn7hAWuNGRCJXydLABMYM4WLswjJOf9ety+G8YTe3d8hTRDyzkNopn/j5sYkqo3OJqEwwSKvesZR+qWnWguLjCYxdBb32bal7D74VpZfII+cfKyhp9i5Te8bL0EajmaQU3N3SE9vRrvVYcdo0oa21JOWUpagIZZpcBRcpJNffnpWN0mZEs9UnrD+s+WEQWGxyKMSXdQ9cjBXt5MbYcsrSKHItpIn2ADoscT38HTQyVa93dAMV4tngDzARO/AnYQiR/bsSp6oXAKX4mkv05avc7EH+7eKRRXGIZx1LTKs+WVx5Czy/Xb6TY1KqKkSaFZoOXXPyo9eECuoyMWnPS6buEY/xZ2EVYcUwIwJ+dBOw2Z0AUwE+I5w64+r8wR1g4yhai2BkMccTFlwNpepp4gsQ/61nAjbDi8H7Zbo4CFp86wipLX8Y1jyMcHegv4K1frD2ReANiuzScPFoidqfvt6axC3W0OM9B4JZZ4ZGv5LUafdvyPgeCmFVCq/guhIB32FPuAq1ovzdP3fYEMnGXgBajmMD98vOZSfWyE+Sft90dJpmY42VE1WlfGNs39+JWKj+7h9T7BX9W15kro8hriB6u3BnQTZ6S85i01d3ejQn4=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1093;31:6TXZbGxe4b3QnEEELlC3Shy0DophFME1T7wwzfxKNOoEeivPY2flxTcaL+wUbm8mWf6sPKtWDeamm124gB6uTYmbxqNuGG4EynjL5UNr0HWASxTcb6s+VCPrO6L83dGLtLZ+R1cNNULq/LYIS8RNMqi5cja0udbOV5yk2Opna8xpU4dTwXw5oRJJFP3pPYiSz8EGf3wKjblaqccQa8r6QMQk03QIsZkzBWGpMUfOnCA=;20:WBNZrSwGO+q+hkPfIHk5uX6KqxTT8xlzVqxrLglwfppdgum/EF3fsLVc7YuKAQ5gbQLqs2d61xOYGFR/cfqpvRJ39TGxOszwkzAsO+WdEZbEmIaENOsCJLgMPaWfG9/JmchqU6xCijGchUehuZPffRiDUldNBZJ+djcKKCLmoEi7vVwv73OgLhY6oy/4MzXXoFVmWCowrDoaRm4+fCqVvebihovL6EbA5wT27L/g1HqMk1e+9KwVWIPNnp2RPoizsg67qHxci83nKieYrVtAKxrNPM+2Ahcuxyodm02pIUPEkBwQ5K+Cl/DUuAd6cG4sdaaZhpA/R8ZiuoEDuT0xK0HtEo4mcQBmx/m1jxmATtrEhD7W07BA0eOgScgS6oGZbIbWEY4/OWgJclCauPmOHMpdkK/mwxr17YX+Ge1qYbDUlTWoWyVZsqi2ZtyarETgoRx0W+El+33UwlnV9vcrqX8KGV3pFQCTNT2no8uTzTeV1+DnvESwP5fA3VjQXlkR
X-Microsoft-Antispam-PRVS: <BY1PR0701MB10933CB3A9D7BA5B92D5BE7B80EA0@BY1PR0701MB1093.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:BY1PR0701MB1093;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1093;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1093;4:hib7rxmA0mjCpDU1+ljN1RXAG7b9QEgXuWBdBKz0Suf7wZfCerBOv/ZZyOCEA183VBbM5gc/u/gPxtnvydlh95aG3SuJJyZVwspqWjM4pTnR6hOD1wNBplaCf023UbnkOPkguqUT4f8AXP5tUeGQil+fW/G6ssXKADbfFPWBrDl8J9syiimQCizyW3yjCjfiO3wtHYesYpypdAVY3Vh82i6tXJUMVnvvuluaDZ031Y5nIWn/c4GELtCdHzWZ12pxO7Lno1V/O8ShZNDwAFuJWIiOHJPB0Dxc0G4cFjIhnEsHQAHRKj5nARuZqwbVN2abSxP4wnpBBp7G3M7Dg9NkRnQxsIrawuzd669IxeQOArNWFHZKfYRryVOImmQN2Ls+dHF3NnwF2GvhWvpMuT+Z+g==
X-Forefront-PRVS: 0044C17179
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(199003)(377454003)(189002)(24454002)(2906002)(77096005)(83506001)(6116002)(586003)(230700001)(3846002)(23746002)(2950100001)(65806001)(81166006)(68736007)(106356001)(305945005)(8676002)(7736002)(81156014)(7846002)(65956001)(66066001)(189998001)(19580405001)(47776003)(36756003)(19580395003)(42186005)(5001770100001)(105586002)(50986999)(97736004)(65816999)(76176999)(4326007)(54356999)(86362001)(4001350100001)(101416001)(50466002)(33656002)(92566002)(64126003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1093;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BY1PR0701MB1093;23:9E2Qa0RiAen98V69/6ZdfLYlQn4Oz71x/Ck?=
 =?Windows-1252?Q?zSarfT7j4eappkM5DehX8S4zCXnQ7AP51bKKnt3zxCmWzrynBMtY9K3s?=
 =?Windows-1252?Q?bfHGjTDEAueBwZcAXy/lR4723wbQ+qEr1b8VvcbiLALes0br8HGMN2Hk?=
 =?Windows-1252?Q?8Z43vMYdLJB8NdHwGFc2dHok1tZGvM0YRnbDzFwI8NX3Z2PZdNQCO4hr?=
 =?Windows-1252?Q?FVReBNKGdBBZ7CkYit7zlmyLkduanIuqtBzBdjXdcuSdO8Z3TtYPVzwD?=
 =?Windows-1252?Q?u4KQg3pPSit9Veyc61O/Jk7aENprItR8cisngJD6/ovJMetWXzJ2EuqU?=
 =?Windows-1252?Q?OcgMOzA9ZlnZgdhx0ktsLIAaXXE6iNrmTYQHmW64PUo/9hKBw6yUvUVm?=
 =?Windows-1252?Q?M9yf7T2HHwr4zHMVx3r1UY0YDjfhRb2lBSxB3N0VIBA/d7bdQk/iOY0z?=
 =?Windows-1252?Q?gT+AETuS/ERNPk3xpTV8j3PYuTABAHeI6G9aH4XMXAS8U2m3Q1ZZVr4M?=
 =?Windows-1252?Q?H8bQW1hINjLnfrLMw9/Q/QxGliVEBjoD4/srgDCI4uWfAqO9rUW+4E8T?=
 =?Windows-1252?Q?605439irl524pSnKvwAoxhrenv3elHE0ylzFM/F/gSj7lPLzQAq4/cqP?=
 =?Windows-1252?Q?vbpCzOxbJmpWZul/i6RUVlnHXusVDyEymmfrhqHWwFk0ZIRVaykpMIdU?=
 =?Windows-1252?Q?8Sljt/rNYCDbhzmd3kx1Jxp6esd+hn9B6iiQBSaGpeQdovbR1tdTTU7P?=
 =?Windows-1252?Q?JvLa0eResiIs/fhnZur0nlR7AWoiYydg8Vcaz+A5CjOMlTLD5ejx00lO?=
 =?Windows-1252?Q?n9AZY4s0xiGYEkANeiXIug4SWTbUmjLgdj73SW+jemCI3SPSnMNT+GVc?=
 =?Windows-1252?Q?Gvi1u25uOtoXk6g7soqM9B5pb1ROobg05dat6dyAH52au8HAHsuYOuAK?=
 =?Windows-1252?Q?BHa4ThXl9VxMz9DZfHLc4mRMGLVTkEdSrubSlYxy+QqvBwJKWJzgm2Li?=
 =?Windows-1252?Q?AklvA91cYnp2tO5tX+aQoYzKX7Kyek/B5OkIt0d8ULz7oXyJojumw8N0?=
 =?Windows-1252?Q?3N7S37cb/bmY0xfOxJ+lA33Cjfjs7L7cYDSxXlwpocMTklUDF0ZgS9Qd?=
 =?Windows-1252?Q?o0Kto5wSCpu0nrVBqwY0xlqzXlvLDVFLdfHq2sy7vFpnUVwQiJBiWl8Z?=
 =?Windows-1252?Q?Asfo7CBj+A6lTBlUAtb6wQ5iCXa4XOw0wv61VTDj9xG+HHdTvnp72+p0?=
 =?Windows-1252?Q?rr/EE6qzLTqUdhqAoT4OEpdMxNIZe63rh8hpipVwS/7YY2HeMvkKv/aQ?=
 =?Windows-1252?Q?no/WpV2leyxwwsOq4vrpWBVNGgIBbLuH+hnZZCmG3BY9qugh5uGJWtfW?=
 =?Windows-1252?Q?wUQcNFogoEXwY?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1093;6:S/GExkoPK1ZV0tbMSiyg5rYt3v6l8cPSYZKNRcB+Atpiiy9eq7Q24hg9f0yR6+bVWN0bJwR6hzLP3XAPQpBjkE9NZwwxBPd9+yq49zrfi3TVePkyxTgUg+ibLWCT8yimhUxtYKiwhPBRfvPFLvLquEz/5TH4ChPp1NyoHy+GT5zmB+3KLmXYPtSckDO8AmIBLQwrYrSlIRFYhcd6Fs36PfRdx4R1+lTagOhHxRv0/WDo+jopS2PwbVWVm4J5KP5DoKtijAyGCciF6T80Kyil/5XtUWI+m8n530cnR4aveU4=;5:HJ0/zgaDXmIkF7wxN1p4OzWYUTeLuTT5FIiqqmzOFRV/rHYJHYB16u4JzZeA8AbIZeIwueopVkeBRiKWn3xZBLkVyQH0HjaoNCEXsCRmjK9nUP7qQLjyWJA/7D2bkCNB/uy5FDOqq8LsKFvxPGgu7A==;24:gQ8Y6xK8qx0uES7E1Xo8u9jTEWZQgbqV2uP+ZU4L2vBP+I2SOduAilPSZH/pcVqG1NFqADQBGaP4WYf6oj+kaSQe6DKZ86Qxlu2c49kc5jg=;7:h0Q4y7UYevqFAPrN/3TeF6oUEN/Z5bNHvGucdgfGRUtESZAnsirVSz/zoO2tEiP6XNGavzZe13Pq/nYZwrRR3qjpJn+jaS432jpm2lO3dVaXuJVol9YdzbeEV7xsPfEWGJlSOzgDlP6MDBqT+g011W9jT5dMlZa+NgV3EQVsxbtomfjCWXyJfIhoVLSMmiJeT5qAR5hgk3G9fMumOlNWqqHXrSHkL4W1CwqBXoMnWWhrRoPCWqLw+aoNUJvNzhxr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2016 16:42:05.6407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1093
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54742
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

On 08/23/2016 03:36 PM, Aaro Koskinen wrote:
> Hi,
>
> gpio-leds fails to probe on OCTEON with v4.8-rc3 and when using
> arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts. Leds still
> worked with v4.7.
>
> I bisected this to:
>
> 	commit 15cc2ed6dcf91a8658e084be4e140147161819d7
> 	Author: Jon Hunter <jonathanh@nvidia.com>
> 	Date:   Mon Jun 20 14:49:18 2016 +0100
>
> 	of/irq: Mark initialised interrupt controllers as populated
>
> I have no idea how this is related to gpio-leds, except that on OCTEON
> DTBs the gpio node is also interrupt controller...
>
Hey Aaro.

It is actually two patches that cause the breakage. The other is:

    commit e55aeb6ba4e8cc3549bff1e75ea1d029324bce21
    of/irq: Mark interrupt controllers as populated before initialisation

I needed to revert both of these in order to get MMC working on our 71xx 
and 78xx boards. For our MMC, I got error messages from the MMC core of 
"Invalid POWER GPIO" until I applied the second patch. I will have a fix 
worthy of upstreaming today which will be posted today.

Steve
