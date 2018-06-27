Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 00:58:11 +0200 (CEST)
Received: from mail-eopbgr680133.outbound.protection.outlook.com ([40.107.68.133]:57650
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993057AbeF0W6Arq0Ya (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jun 2018 00:58:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxIpJq916+Q8lEEwqhiJLPPNEQPc9BTHjeSxHmSyERQ=;
 b=YpGUyM8mzGMktdgKCRPzsk1VXWXmYDbtYaWMBecyV1B9W2U+oXZdKB2lj46YwIwBHPb+06XAsqosqicJ78a1N3gTDZ2VJLnCiN8crcgSqSagSznscVzJcMDi5JHtt5E825pD/lNy317IFJvHABbubf0XOJLy0x+S88jcCp6WTDQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Wed, 27 Jun 2018 22:57:47 +0000
Date:   Wed, 27 Jun 2018 15:57:43 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     John Crispin <john@phrozen.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>, Henryk Heisig <hyniu@o2.pl>,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Weijie Gao <hackpascal@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Julien Dusser <julien.dusser@free.fr>
Subject: Re: [PATCH 01/25] MIPS: ath79: add lots of missing registers
Message-ID: <20180627225743.aghuksdpqpmg4m4b@pburton-laptop>
References: <20180625171549.4618-1-john@phrozen.org>
 <20180625171549.4618-2-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625171549.4618-2-john@phrozen.org>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0106.namprd06.prod.outlook.com
 (2603:10b6:4:3a::47) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 055d84bd-a0c5-4ff3-b9e6-08d5dc816697
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:mGqOPhajKhd0yhZVhglvN9aNMPhpXXG1coqWWBV0LgF0zwxEKZW67WGsspLs0+HKSfHewtPBxCa+gMyr9S9tj78hOUCj9Ys3W3cd/renkBsrOCan7ct9+fQTubc4HnPDcDSsQPN/xo+VOjvcR3NSeYffUMK52vyhP6GgL7ogeW+yEtcMJsgP14Keq1OAQ0Z1YwIkTR3PGCChLeykJYtbFnjSyCRuZfc8qlf+lHvSlExnmOjVk6u+7BJXRhMB4Hq0;25:RJclyF62l5ZUThl1AdtNMZanADuFzNKZ88+DxteU0L+XICPrnkvcw3Eso7HmAb573t47TnUdNLn//pUMdSelLbvKCk8ljNYzY5MgFHyAeso7QbNhp8msYO/FIOs4nk3qnPnuRtFfQWY6s4s2Eha2cT1/cS+vrnaGpFtotmwDcF1DTn3nc+iGYF0DZDZsgoDvfzutQjylq70dCKGfP0mJUwjLOufZKdmx5Ba8dqSSZK3DRCdrfoouN7lOBiYJV4KFtBUXh9SrQLaUBdGS1lriKW0Syzp4gHgOh8OLy94HnWOehPPdhSWUvQTI32YgBVv8WE6rRdY6ihT8wQlqjgDF3g==;31:CTXnA/S7HfuSEXA3NvLex0Ld3jogp5BCtEoQV1D6vrcaWyYGPYGNxp5zKaro31TS1MmU9VlgtJg4AaQTWlyNdZQi5f37FxVaI1wH21kTLoFajzgzl7x47nmeqWahzAR4rwUZKB0eCuD+rApDPd+0dWl2Sn6jmhyXk+VMIMZVK1jq+cdnGDUBVwdB0b/cn6SVnjf1t+sq0NbOwrMf2gWEuSkaPKfXKAHm23HN/QsO1aI=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:0Jxn052ohdCP87SPG9ceL0Nz4MDGshmjlXY7pQALxrxSy6FOp3683IbbQfrlVWA7zLZtNbvxTENckR5UKdfyms3N7fOU58Bgq04cafW4lPaJwDn+KGEZfF42FhqtR2jon6L5x5dtQZboo6VRNNis0bimLhKNGg8Gg8f+SNUGMf07VrftHNhc43fJzNz4/XmTVvTGTIDi8e+V+vA+EEuWZNzympcoJlV4QEWE7qfwziFqHFn3ctPaW7sGPajlda7v;4:3wOhdllDF5/eRWnLjZF/RBSC3eWpHxIpA+WkQa9qHSur/2J03BsJSOcf0XfixXHk3TiAl2owJ+uf6bizP46JeNwdyL3WRGaescYzhia5ZdnnEdSWxQLCdreXaISG9xiopIYhzpfJ5LuIanStlrBulgUIiEBX3YRsxOX8QeI3OABvTSkiFReqnpIaukVzj8EX4U0Alxy7+F+c346UjzCCHvyVhQRFqbzaJDqKZ0eT+pxU7w4+E/859XLJt+NcDCOYqfFqiUvMeCNNdGd6yckdlbOmOjdaLM0VglOZxF2xC0ZmT41PyvibrFLacJsZC09QPu4bPsI3RkQD+SgvKIw3a6sTFXqXQL4hIyky7LY7RDg=
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934969ACAB3F2578EA30ED9C1480@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(136003)(39840400004)(376002)(346002)(396003)(189003)(199004)(68736007)(446003)(1076002)(44832011)(58126008)(50466002)(956004)(316002)(6486002)(9686003)(11346002)(486006)(5660300001)(16586007)(229853002)(97736004)(3846002)(23726003)(6116002)(16526019)(186003)(386003)(476003)(54906003)(26005)(6246003)(305945005)(7736002)(106356001)(39060400002)(53936002)(4326008)(6496006)(25786009)(8936002)(42882007)(52116002)(76176011)(6916009)(66066001)(76506005)(81166006)(33716001)(478600001)(7416002)(105586002)(6666003)(2906002)(47776003)(81156014)(33896004)(8676002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:w48vluQH+rFNUIKG9D5SGMrCVVdgnf+65lDmgKrdn?=
 =?us-ascii?Q?6+w4Ss5CDvByFcKdTYOiJAxiXeeosm0DwuDU/sLIToY1YQVkgKF3zNRqOtCg?=
 =?us-ascii?Q?BRiaHsFMN+QWVOICbTtxsFlOww482pw1zk3V3uHGV/iQDv9BnafQ0Mlzwq7a?=
 =?us-ascii?Q?8os7GumBjkXqRjaMSOmj9SeodLzKtCsl4YqhHW6fazTvANo5Iaqf9/cxP6zA?=
 =?us-ascii?Q?wUFu3U8v0mhA7CKzB090V0QK37ka3qBBKtep+llcaHXMqLL+2NK85/5gi1WN?=
 =?us-ascii?Q?JZAFQ4K4PXVYKHH7pvz0ZHkPF3G7Y+WhZ9xCfb6sChOQDkDC5CPme6bSc6/l?=
 =?us-ascii?Q?zo+8+rN5N404gXFdEo4A6pThD9vievtrOAes+kYRBmI+k7hmDwy3uhsPxLEg?=
 =?us-ascii?Q?IhjM3kBPJ0NBWEXtelGd6hwVnhyWO0SI+akX2CDU3GVZuXGrbIpIIzCRYG0L?=
 =?us-ascii?Q?4E37yuk705nD2rXXOsV3hXnpoNg2T9QAfkqc0ZRbyg85ZJJ51kk3/1zTRibt?=
 =?us-ascii?Q?oBh3GU3AB2tYGeXpu69JyLRHv2VIAsXXNbwtuABVnt6FakPzG4nfAHiOKPin?=
 =?us-ascii?Q?6vxkSnYNwj9wQlCO1oVYt51sXFPYRDBzJJj8I9IuiglZY3M8hYjeQWi6wBKc?=
 =?us-ascii?Q?KXaeJGw3PuoFvVOEC6ZrVEqo+2659kmgrop1v3za/hIBVk70XIkPWaWU+u7f?=
 =?us-ascii?Q?x06ilbY0BmMI2u3DFr711pN3rujQVumqkZjHy4rHuH5xpZg0IMS27+wd593w?=
 =?us-ascii?Q?CgqF+nRSXwG3gjwzQvqoSa87l/u51qWa0INraWNzBiQnvmPMgHrHO7x2BCyt?=
 =?us-ascii?Q?UtK+BMArbUYw+fy/9f3auUZemaETGxVeG2DwTbDWwiR9Vas8ST3YNLQhhK4d?=
 =?us-ascii?Q?OYmavPCgIZhWLvvHd9VMuRUcWbgPg3CdZp/9Roj2PYGbV+wdfDkArz02OkVV?=
 =?us-ascii?Q?vsmxbrbOACQpkvekgp+p6i99+Y8bc8FzmPipmJIBnStrtRxsAt/YfxMib2eD?=
 =?us-ascii?Q?Jvkp/gBRWu2o+WYAB16PwcIxQLK19u/wHqbPVoJw0pys12MvBAhNkq+a7apk?=
 =?us-ascii?Q?c02ajJ3N1tZ/yoYTd0Ad1TgDfh2RGDHggj4PUAF/gHpT8BYY3/+Hc5RJEbHG?=
 =?us-ascii?Q?Oid1anOT2kmCW6Zm+g0R707rf2c4RbFBzgZlkadmtww29cDxqoC52FgnaDza?=
 =?us-ascii?Q?E05cs2BxMHm2lWZusZrGD28tFuI9UWOrCo43/OB4n967xfWmeM/choEI7aAb?=
 =?us-ascii?Q?J+KVd/+/LV7N1MDwS3JMSlto1XH6aFt4QtUWJXLqTqP6iqPCKWhVR125Aj+l?=
 =?us-ascii?Q?mxbdHD7vfosdp/GgphxUzXjurWZVqY5iSfSfqIjonisPSi42aNbreUamR0Hn?=
 =?us-ascii?Q?8YEFVfpT9JTqpuSUqi2RzXiX6g=3D?=
X-Microsoft-Antispam-Message-Info: pxYcy+q5l6cewVV2ErgE7kFXqsmtqqoGNApPVbfU1l6b9IVnC79xRlBneJLPLBu8Uuq4AUcffkJlhF8HJy3BxIney1MS301wve7WhjQy4g4pcXJFlxGXlY/D4pTkEoKBdlVvSDmefXj9zWM1pe3I2Q4YQ4czWZJ5IPpkqwSmf1jUpo79cO+AesM29bSZbqGioXtOm7v/PZyNm/sivHLiRMZLMPIlzaVZg3DY53O3gAhUU2NiQ9T6ITQgtISuTOjEcmolAz8do9lhQGO4z09YdU7CeGwVwCpEZhMVBeKsRFLIeg/4FXsuf1hgpGvRPx3D+PAFjyxU28aqY5b/cdXX3Nv+bO6NiQaz6biXFJLAsHw=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:1ox1jDj74CBKQePK6wKqZGURiMbgJfm6gyqGcqvePgpw19aW/RUczzqhvafq8hoCdX4D7RHG1mvpy/WupRi0R1h1zCqBWJivNnlM612tj6QGCIxgKCfsTuSFiUka6ckmua+eCyfTfdADBFoWn1rfJ/B370Zp0xPXBR3ytn1T+WHvfWZdxUQ6nvHVVNDwJ0m/AuP6tLXBpM2bKuuyPniFzvl2rkGAlM6AjhdnEtnqVLCTbB5LOAsXPUTtRRewuZbvEQ15BA3vZ0Bz7Y0HWZjuO+TzvDc5xQ8SLnvHvm2HM8AgcgwhSGktCALDgdMrS6n8BY+D/WU0R/bebrL2YLD9eDlyUfG6rX+cfPR05vmo6VZ7pPvOs2cNaaF90ObQj7UCL8qv441w37ZN9u7zBnsLT/qZMLbKSp/bGufGH4Ynb+9spMjdl2GWy0Mr/AsIaujuo/6lSGI3y1w4jSh8/aM+zg==;5:QCWCdyuqmyVIY+klPYGjwl8iduChfTfsfk8VM4mowdr2hVmMSMEGVK85eARH/7QgOEvJz5G8zubyKQtKhwCs1AVXVpdKIMAq3sab9MdkCGeA8UjTJx9Bmg2ZOazxfVhF4lpR/Zi3H0kmemA+UPQWqgpHsbgLJc/GdW0uT9wPeYs=;24:fOhyKHyZ7yK7bhcslCYx8MF1YHpgeje4HPJLTi6w+XHk3CIvE8viXSHNyg+a0NSBFGZ+fxhwNoJ82x/QJnhQGeau6rtMgCb7WVnNF5tB7dQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;7:uYr7x8dn/Vw970AFxtrwuEYsedJKSyi9lpKBTnhp6m+9PbzblI0WmfKg94COipayM+QR3tudDqWHdj1LcBy5zoeXIs6l4i80ncRvFlRxwwDnU8yg6kR2jwD57OWb35Qjna1e1kHkYe8ySfDHtH8cABMa/Y2Uj/46qec2hfL7vGpA7q/5WSph99OoHKrBMyUEh+zlLAGiYWYZiza8G0yhDbu0jEEglH+83HyXq7493vekt/+XUUCMmqskyNCbrZus
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 22:57:47.0717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055d84bd-a0c5-4ff3-b9e6-08d5dc816697
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64473
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

Hi John,

On Mon, Jun 25, 2018 at 07:15:25PM +0200, John Crispin wrote:
> From: Gabor Juhos <juhosg@openwrt.org>
> 
> This patch adds many new registers for various QCA MIPS SoCs. The patch is
> an aggragate of many contributions made to OpenWrt.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Signed-off-by: Henryk Heisig <hyniu@o2.pl>
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> Signed-off-by: Weijie Gao <hackpascal@gmail.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Julien Dusser <julien.dusser@free.fr>

That's quite a list already :) But since this is coming via you could
you add your SoB?

Thanks,
    Paul
