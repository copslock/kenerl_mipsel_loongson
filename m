Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 01:32:16 +0200 (CEST)
Received: from mail-eopbgr700101.outbound.protection.outlook.com ([40.107.70.101]:10651
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994572AbeH3XcNgpVKf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Aug 2018 01:32:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc+2wYySETl9uRpPZRB3pifkGDF80HFpocnz2DU6kgQ=;
 b=LJAFmebFLKKkC9J/cbw7PgWkVjPF29V39aedWGMQLDrrc7Fq25PuuMYbGvPN8ROn9XO7ALZdEYScLrMzf/9qhHWdzNaHiafIf+wohP9vCShfFJIM4T3dlRjShSAMHJUO/5IKdJwNfokjE4d8yFSfey8ihg0UyafMI/1SGgb6Wqo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4940.namprd08.prod.outlook.com (2603:10b6:5:4b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 30 Aug 2018 23:32:03 +0000
Date:   Thu, 30 Aug 2018 16:32:01 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Dengcheng Zhu <dzhu@wavecomp.com>
Cc:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, rachel.mozes@intel.com
Subject: Re: [PATCH v3 1/6] MIPS: Make play_dead() work for kexec
Message-ID: <20180830233201.3uufivhypcnrzyek@pburton-laptop>
References: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
 <1532357299-8063-2-git-send-email-dzhu@wavecomp.com>
 <20180724232355.z6j2wvs6srigr7kx@pburton-laptop>
 <5B5F5DFE.9090702@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B5F5DFE.9090702@wavecomp.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:3:c0::11) To DM6PR08MB4940.namprd08.prod.outlook.com
 (2603:10b6:5:4b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df57824c-3f16-4277-00b9-08d60ed0cab8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4940;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;3:/bF/vTnZ/Ph93I9j7VSzVhaFXk+gAK5NiUeTcUeFau67bDmjOcK+m75aYkqAjoJMHwbEgh2h0Zu/2rmyiT7dTenn0tL4HUDNHOTUwzzFFxiuYQkpgZj0aMehuA40US1wtEHDH4+ZpAVkRT4fu2n0ADrOLpFDBbu4cZBvFsWmAVjQWr737oyezYgPvFGOqfTAOly8bMXoIz2HFn2n1hueOUbHg78keVVW0UB12bnEbMM8kimXX8JMgsR5f18Zth92;25:GvRDr5+gX3y7SoQnNokTZukKOHhjLCW7VtBPDGcgwShnV3xlR+EFoYZzZzRPjVngx9IxTI1w6sBPkthK3VlvSzHeUMXS3XxoIKlXnavv0xE3zpVGWqRlMOxTVKXNbpOEQ6neI3w1JTd59f4Rwvrv0cCo2k7Cj7uit11jQLNoJQLErNvgIQQ/nUhubGMfWwRWCKWd+QwEpbbOykbtN+2PvDcSZcMRAd3E6+2E0QCJ1Xfhb4aYvbhAqNq8LemXRilAGSsTdzdrbFWyGdwJcyxYVKddAsl7qXgkCXkAmU4wDsKqx9Da/41fx7cg9ArVtPo0v0X9bB3PxkPc7iYnz0ngjw==;31:z3BbFTnAb17e/gnmg2xeiCm/skgWfpwazjyL3MqVwipXUxVOfqLZp1ae39oNzKvplMESN3t8/cInsEh1JCFb9kPNgRadMAj4Q8NmeiYDf3NwTYB3ScYg7a9gZl7xdCZGWYtyVdMEe80hibfCk3JktTCacmp/JpsFU+RIzKbdTq1ytlg9FzH44k7aJCq7PvlOmjTbbytjqywvouOg0AjJcgOuv2lj8Ef+kX7jLIW3e5o=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4940:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;20:lOFIjdtzrVR0RHtGl/wRjJOy5N6C4g59f13YmVQmg7Tmihu7aT95J+LJf0iIdhvE8OCvjSPAGNML8nyOX3ET0mbkC2G5sXaUnD7BV+YpkKf4X8WF3bG7KVlt7webzHz6kJh5vzJZajYpdcChjYcXtx3s0prXm7x9QY7dPIHBXF16q3DjXZST+4oIqgUVjdXKB9V54NNdCAppjEIaezAVsgFUWygqtQnqIPSxR9+nHRXSdqN4C2JZDc4g1QMI9kfg;4:0lwvO+9X6A8bMnDRU2VlVzUZ5mm5AEwrMIxO8StIwT9BbYNMn1cRRrx0NIqEqflH1neYoV1DBKmTQib4faiqBeBb1B6svpFV9TP2DTJeXIQm84WtzCDxq7Iz1GgKmjW5ChUNGQm9adpvGOxlAcDPTtfbJtpPmi49B3QuqcpNbuqpmO2+0VHrs/goZWRGmS2ReItSAdlzVEXrOzNFoWtvdaVKzxcDF6Iu0N5qQedz4fwXLuURzZ9fCifFwIT8492TPd1u7VNObyyqWk7VRboXsw==
X-Microsoft-Antispam-PRVS: <DM6PR08MB494036AD56F6931DA5052100C1080@DM6PR08MB4940.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM6PR08MB4940;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4940;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(7916004)(366004)(376002)(136003)(346002)(39830400003)(396003)(51444003)(189003)(199004)(2906002)(47776003)(66066001)(229853002)(68736007)(93886005)(4326008)(25786009)(6246003)(23726003)(6862004)(1076002)(8936002)(478600001)(3846002)(6116002)(97736004)(52116002)(6496006)(26005)(16526019)(386003)(53546011)(33896004)(7736002)(76176011)(33716001)(305945005)(42882007)(446003)(44832011)(11346002)(956004)(476003)(486006)(50466002)(105586002)(76506005)(106356001)(6486002)(81156014)(81166006)(8676002)(58126008)(16586007)(316002)(9686003)(5660300001)(53936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4940;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4940;23:4vyFUhWmTEEiQbgiHwFvF0Nrwy0CiJfPWYVHuxtM4?=
 =?us-ascii?Q?ldo/OuWJ/yNKFMhmADMvfdjqNjMQEGwyBa1w0QtjyatEjmontYtDa42Sqx1h?=
 =?us-ascii?Q?ri4ayKY5VkLVKFN4g8wf9CqRanexTO/JIrixZef0NeZrNZaNC1XYjuEwtcjh?=
 =?us-ascii?Q?JavfvtFoTE6TR1HEk30Mu0XmaKqfpQzcV/GZy+xnGAc3w6/pcT84/m6Rkrzx?=
 =?us-ascii?Q?G8iJuSYOha5ckTSeuiQuQZBaCy2cVnFN1GO1TuwOzIK5/nVtf85W/InDC4mD?=
 =?us-ascii?Q?5TzprF2bkrV+VB5qZGaac3NS2B4JCfj7aGHFeJeESNJcnOHGtziZmS5Ukvrd?=
 =?us-ascii?Q?LKVHChqO9ZFav3leiqibdB4bKNQkNAu2klLg2+Mv/voIwfhmpc4UhivYvkUz?=
 =?us-ascii?Q?YCPPZcSFfXYnYU4nNMnWEJneOxMW51Etvqt86eCznxJv+3St/EQcBndv/ytD?=
 =?us-ascii?Q?uRde7kKKUOl6cuzIFYRfDgsXArNXU2gPoupfB/4iRjOpWrj/alqKeepYLczt?=
 =?us-ascii?Q?D8Nu58JRjVI1qQYH3W7O7epLUu1YkczzFoOUdteikPrJo48jcFenxS1BGtIt?=
 =?us-ascii?Q?3Tt+oHlRcT2Q62Pdl/+i5ZTEw58At1cvsZ/MWpMrYh8kjI9JqmApzsA6sUnd?=
 =?us-ascii?Q?M5fLyoJVtru95xrUorgL9Yg2q0EhPDLHc/ybPIvMfDGOnwVx5cIOYumCtayE?=
 =?us-ascii?Q?MhBsFg2EPOt4NfqA7ER0jiXUs9V1nLn5ioAXp7Zlhq0DAWLDTG5sRBlIu+xL?=
 =?us-ascii?Q?hUNWg19pz5bImBmaZhOSQSA94urhn+K0fwdDOz89nzUMT0a5d4p1/L1xDQf9?=
 =?us-ascii?Q?abuiNNgQAwEnG/uCylOK31fDljTZAkXPxb3Pgnhp4F85GMEUDXJkxWWdesF5?=
 =?us-ascii?Q?3EC8GlYIRNClIruyvUV87v2KGTb8D1SQyS0BoyjL1muno6gdNr1aNmkX5CEQ?=
 =?us-ascii?Q?PX969LyW/1zLJrIl/ibDNyoPmoQmI/Fz1boj8FjmB8U9BXfobQnrhDp53ClJ?=
 =?us-ascii?Q?4PTItpX/td0APQRaajmX6VUEkRumLi4yHVbxu0RG7+G7X/UhvhcdMApC39bP?=
 =?us-ascii?Q?3GhA0XGjQEpSXb6RCdv1jrRouSY2f9W8js1qQhTD9nqPCbHiwJxq/Xgxkr7M?=
 =?us-ascii?Q?Anz0iDpmbzKe8Iuhcgz576BhfbxQL5fHkVGPOI3MWd/B6FrGfApdRWE1wdTu?=
 =?us-ascii?Q?tbWeiw2ovofQdK4oUbPgL361to4vK1fSNMHWqNkU6ezZydXpl4o7I4KoV1Y1?=
 =?us-ascii?Q?LYf5Kjx+5mb0zo/nczBHZG0zT9hwnq4rofsB/D/7lkzHiwBkP0n19koEY5Fx?=
 =?us-ascii?Q?12QpPz7BL+hkFNGMs/iKCVmasa3zWLpal+M3VvFJB3zO3wuJiT80EJ+sF3dV?=
 =?us-ascii?Q?vwN3b6RT+Zn89IawcRLcf+gHMMqnqfajzjRqz9mK8hnU8uOgK3BQet5JUiDx?=
 =?us-ascii?Q?tPg6J3SRg=3D=3D?=
X-Microsoft-Antispam-Message-Info: UcunOrh78UmJsfBvYv65FpQAsOxjEkD8g9wLdfZHqPnirgAQRcTNF9PC48T1hdjOMy80af8Vuo0JeqQgMdPOuxYAZyhYQMNiNJ1bQ5/fsvrXmJj7T00wTPZPZza7SR7Lq3IzFp1zhzBhvus/xJCxhG8il45fgD8o/6n9S58ygHoGmAsFmvk3eDWzySebQlicjOOguuux2byplka5sz1Qw1sfvHDOE8KZQgqufMIvfuLl4HOLsTq2Y3UrcoihQIFQ9mmNknz4DaaCC7jRVuB4drOtMM3kF6KQylSVhBwtxVTi1l1+1Zkg7EoujPeg/ss1FI/9uIkOgeKJEkRVrXJzRoeQsnQh1GUMFW65KntiB24=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;6:Va991cl/KfhIp/e8brYb9vCkCf+n2EVqQhrrsLzqQUl1B7aZ1dA+3dcW4bPRRfK6y+O6ThDhHtYsSUpinpfoZbUA+MsRFzIgJVu6B8Q/ksd6pg411GosfRUEQJxJ7sR4g2e38Q8rdX+i2C+VuU3m8sEf1l3y9UcvqXuZozVwzyeNkknveCNKMpUAg2gVCBjqcn9vA39Zh10FIF8qAEU+jr7nPxmWRZbB6usj/IJhJi6Smu7HZtDK77PifRMTU5QUNWus8SX5vBxETWbflkwexKrFKhZ0XO6inL/dLpXbxZXkVT3MDAUt5gh37+BIe5Bh8W2fP3XT6dAdiidUsAkLTGMN3uSS27GvvZzvpVOVX8viwEQVb3GjrxXpLdG6BnV4hKbAzVYV+7ok56se6VmQEjlZv/BVEMrpI+A6jTvKIEj3YYOFLu/VwE1/7yP23DWAF1XEHfaEvGRYZnDVfQfUTg==;5:xQ5APh6GWSQuNWMw36cAozfcA+fpk+8ydaQ8Zv60Uyrz8CGpl2+5luXFDjio9lqBK4ALDLbBcYN33CRS7NEljdnyT51jWnKPPXPBFI2zsC3luZwnDzzZFnAKETdHOyNMdprT45yFfozyIXP+F9VAm0Xa7og2JZxie0ZWY0xAVis=;7:/lj1Tx5uaVzRW3vdIXpRtNDDqOXytCVm/C13iisY66Zz27cI2S/Nq1Dv/7RGoqn+o8sNm1PMV4s4hIDjMr9pfxLjEY5Wgr2s8yIdYG983XhGW7kgswGNcyribepgdx7DtHo/URxv7prRvleqFZlRvX2jU7fbESCKgLxyadApJ93ZgzIKcP656jft0vY7cKddysKfc/9qq0ASeDwoEWeOufJRdfCLbi4BA933Kxc+wCLQWUVicKe946WMDktUlOEF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 23:32:03.4675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df57824c-3f16-4277-00b9-08d60ed0cab8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4940
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65810
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

Hi Dengcheng,

On Mon, Jul 30, 2018 at 11:50:38AM -0700, Dengcheng Zhu wrote:
> On 07/24/2018 04:23 PM, Paul Burton wrote:
> > On Mon, Jul 23, 2018 at 07:48:14AM -0700, Dengcheng Zhu wrote:
> > > Extract play_dead() from CONFIG_HOTPLUG_CPU and share with CONFIG_KEXEC.
> > > Also, add one parameter to it to avoid doing unnecessary things in the case
> > > of kexec.
> > I'd prefer that we use a separate function to play_dead() for this, for
> > example we could provide an implementation of crash_smp_send_stop() much
> > like ARM's which invokes a machine_crash_nonpanic_core() function on all
> > CPUs other than the crash CPU.
>%
> > This would prevent the kexec/kdump functionality from depending on the
> > board/platform specific play_dead(), and wouldn't need these changes to
> > all of the implementations of play_dead().
> 
> The revised play_dead() is JUST to make sure we are turning off CPUs cleanly.
> This function itself already hides board/platform details. So it seems a good
> candidate for turning off CPUs for the target platform.
> 
> This function is called only in the newly created kexec_smp_reboot(), before
> which cpu states have been saved.

I can see the appeal, but please see my reply from just now (which is
accidentally in response to v2, but still applies to v3) about cleaning
up the changes to play_dead() a little. I think that would help it feel
"nicer" to me.

> > We should also be calling crash_save_cpu() on each CPU, which is a
> > further difference from play_dead().
> 
> crash_save_cpu() is already called in machine_crash_shutdown(), which is
> prior to machine_kexec().

But that only happens on one CPU, right? See the comment in
crash_kexec(). So aren't we missing the register state for all the other
CPUs?

Thanks,
    Paul
