Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2016 14:03:45 +0100 (CET)
Received: from mail-co1nam03on0073.outbound.protection.outlook.com ([104.47.40.73]:58010
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993139AbcKONDi5E1oc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Nov 2016 14:03:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=n0d6CXBJBYgT/nl94gyATEsVcZ5Os2qYjp2GZTAsWbk=;
 b=ZqaNcwQyM0zkdSm0pTCrw5YToUaaIkXXjc2W5LMt+2eWnFWxlqey4UfjdEdMgE2B/WnzD4XHcvdPqzImwsE8+jA+Cokw6zEGChddhiGdreqJLYn191psR7AUOOVREFqousp11UZRCmj/FxzCxfPTX9NEEaX4SZJLGKX6MYWWlB8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hardcore (88.66.102.28) by
 SN2PR07MB2591.namprd07.prod.outlook.com (10.167.15.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.649.16; Tue, 15 Nov 2016 13:03:26 +0000
Date:   Tue, 15 Nov 2016 14:03:15 +0100
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
CC:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Message-ID: <20161115130314.GC2772@hardcore>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [88.66.102.28]
X-ClientProxiedBy: VI1P194CA0003.EURP194.PROD.OUTLOOK.COM (10.175.178.13) To
 SN2PR07MB2591.namprd07.prod.outlook.com (10.167.15.21)
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2591;2:FSKftI6xXwbr5Of9+t6+MkFy+tEoTDl9Y5mJPGsOt/s83oX8H5feexMkkPVImt/6B1+vhdwHMewdpMTh+IXy0x2nbIYbkTH22GveEy0NAeoWv+erqG5WZnF0ogn6IRWeTOi31yg/tQhLlnKdj6KhSFeUvKqJNDu/RRSTDyO687U=;3:DZpvNA1xpyxXWvArjI6+q0cBcZZ9icg9MDwt3OfuLPWF4g2W3pAZOaECo6pCnRjvOvB35DyJ9rX89njfo87gXFJyvtn0OUG4+TERI+trJWpokngkUQlaxRdjNCysOiMuVwHKUT9r2i/kAtN2qqyioP0L86xJPx4783roLdNrDMY=;25:6drPpq9Le1s3ib0F4igy0hGhl0qzFkOmIB5ryuZGjG9Q+13pkag9X84UiJXs3sCJfpvjdHaOADTZ5RSQ2t3AAsMBvlXAElKO2CpMZ7Tf2onL1ovKOs/W1fbECHgA9quYbhGiEoX9BLsupMy9JbrglpkHubCo1gIrYYsPpHEyQUZQTFA07zj+MRhlXClfOyJApxusvt7yX3WTlu/YVsgMwYEL6rTWAMF4hwQTpBlEBS9Qy13SlmexZ/gQJbi/wg0y0hDEzAd0Ig+lrHuPumUYxsUIcyEzMwSQoV/xw/ZOQgu9/kmufYe4l2E8BW8pmDZfiCxaVgBnKm9VGgGnvV2qDbui7wuXltkmlHIXELdo6K0xSn6YtpAHOroNx32RZkJiBLktJyB4TfBvCE8ZHj55jQw+k8c+ducWV8TnKhnqYI8Xb0RQ7Gnf/gBGipwwynuH
X-MS-Office365-Filtering-Correlation-Id: 0db4ed98-d079-436b-17f0-08d40d57cac0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:SN2PR07MB2591;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2591;31:tJBSOwI3TAF0DZ1VCXcnKp3pOu7yN575REHKPphGFoJXsAB3bgBvASojPQX0f/J4ikdU7xiaVh0EJ9tyUQM1A88jYR3+sFtuE6VDzN2iaSKi/xLO4siyK8dexPLXCplYURdo+AiAnALx7OtaD1FkRTGvvW2+bRb1Yi4tGjylNTvkYyHxPV3u9VE+tz3et/U6eXHOKxPZ7gO12xYo2Y8h3zKzrJxAcnRRww+p8LReEeiMeydG7ZV+0+JU+tLL/vKw;20:BKixQEIq+OzEARbzXUh5k1vqrPpt2nWd2faVu0+VIzB5X1Viv8GeSKzhLa2392Q38NTonL3c1xi4+rgPdhBsvr38yp+e17TCPFd/mGyt8osLxmHAljlDCoGaYw3sCze3qruj1p+qTUYFMZDEBL5TA8n41XMYluXdVC6lJdGoiEmp0VzjJUC6Y3+U7ORBv/Rzv9V5xPBAOnfBX5VFf5KXfrSOWNrZxjRtKg7rVnSDmHVSGJ9rbUR1XoMgv81Wv3uaSURsiq3vdjd4bKmzkLaRNS5fZv0w8PIl3Tc73ZBjdOZ3hRbWMbEUsdtx7VF0drV9OXhTkWMlOoZswCsRpUSu8gxZ0gMplY8S2jr/sa+RWrvqbw6upYNdy6Jo7xNnlaNgj5ceBotB6cWVjjBVbABC7iftY2RVo7u3qePU8MLmQUbCLJmQ5Qlq3+uCFBqmKr3zGTiwtO+3HxtJFo3SLEHIcmOTc29W/RzFQI+1uFRrSGdr5Sx8hzz+4BgchFlozqtK01oTKdpMgSDfP8vgEofRCSK0JT50vnccCAqEG+/z1QzQEQEn2sdegVlVlJcw6iQemnysSdWQ4dvzDhY4iggThkV3qo64A9zzUw5FkkPSyJY=
X-Microsoft-Antispam-PRVS: <SN2PR07MB25917B8FD6FA8C556D7219FA91BF0@SN2PR07MB2591.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:SN2PR07MB2591;BCL:0;PCL:0;RULEID:;SRVR:SN2PR07MB2591;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2591;4:eEh4eMVMZ1ElshMJV9d3hnDILFBmwUl7zTlcwrBPj1Ye5aXDaaYvxrij+2id/Bc6FNXan+lnCZxqTV9ze8A0iBpfQ/Re7hI7kY5IpjQd82e32m0I0HHszjG7rwYlumOQrnmnrJHPulTOQsLH++YfQpDDMTK8+IIincD1qUf2oJokve26J1w8ypwpuI5ld6zPmzRyrr74TArjIsAD+Dw07RMNqQdWzwIDfls0exUbmEtOsxvQiQgPzpeGq5E1x+FaWRWQL2w+MG4gSEknpMXUVdr6b0SPdmPdhAAIlsj1g+GitUJ2UJnA3cSAjAKmFB7EFNXom/3uD2tWgZj4reYETZwTDFtEgQLsPVHar1j27DaDBHPso7VwB9FYeByd9s+SbeHgFknfJtcpz6NBqq7O2A==
X-Forefront-PRVS: 012792EC17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(189002)(24454002)(377454003)(4326007)(54356999)(4001430100002)(83506001)(50986999)(189998001)(97736004)(42186005)(110136003)(4001350100001)(6666003)(107886002)(101416001)(23726003)(42882006)(2950100002)(229853002)(77096005)(6116002)(1076002)(81156014)(2906002)(46406003)(3846002)(68736007)(47776003)(97756001)(81166006)(33716001)(5660300001)(76176999)(33656002)(6862003)(7846002)(66066001)(305945005)(50466002)(106356001)(8676002)(7736002)(9686002)(92566002)(105586002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR07MB2591;H:hardcore;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR07MB2591;23:Ome6XFGm6YadoNtR+ro7REqe9ijPnIsdmHYud0R/r?=
 =?us-ascii?Q?UhPbhGG0v6FdAhKQXddF1bTZPzODHOlRuj9g3GTcOFcZtnF1lFP6gePzK1Nr?=
 =?us-ascii?Q?YPYXX0/lFxim6bwJ6rA/7W3T0jalS1NmMLjco57WWIZOFBb1cwbvwSVMmLEi?=
 =?us-ascii?Q?C0w0H8mdNJ65v6YUOevgXfLdgBXLfoGX+bo95vywCL/HJnwgkEcxqPD6pEzC?=
 =?us-ascii?Q?GbtcS9t0Tbtf4SkPiDKdCnCFGul+c37+3LLGKcDzYUT8CSZBtY5brXa7hcg/?=
 =?us-ascii?Q?IuQugsFh88+EDW9R4cJbzUbLhEooSfU1IveHVViwnDMdOXKHF6UjYvfKiXc/?=
 =?us-ascii?Q?mFVnffTtnMlZkBr/IJTkMYfGsUPfdB8Fq7QMXMj5fbUbrnr7dYF45cqVpePu?=
 =?us-ascii?Q?GNg2WtgtdK9E3RxvtNu+iNDkHChTybd0J3zjLkguISvjIr/h6K8+gbWf7NXf?=
 =?us-ascii?Q?cu4cPk95cM3UmVRdm23R4kOX3zjTpXcb0lWwoyHdR1ksn+PZvLHEbz5Tf0QP?=
 =?us-ascii?Q?75UlQSdtb3HSqaOBhhCMeYQrTF4vHSldzUq5f3QMcaFopqL/A4Vac4CiKgma?=
 =?us-ascii?Q?Fboff5aCk9TUh7PPhhrW0uaVnp+fm0LcOYGC4Dt78DP5vLIoUMgqIZL+rDQi?=
 =?us-ascii?Q?Fm411y0aW28GNvZL40kUMnJpEVKpvFq3WQlqUD+VPZ5zoyM7qasI2ZKO4oNI?=
 =?us-ascii?Q?0pekANyvpBBHY0/vxU5Qbs9Sp8WuDjz3gUyx9UgmYvAYgwS5XRYiZhsyn3LZ?=
 =?us-ascii?Q?JxeqYo/bgVAf2hxO3KLPh5nM+5LPPr0tRcZQnxRPGDmhGYgy3aslf3OU3hYG?=
 =?us-ascii?Q?RimNlHaT78AefCWVCUERRUmkS7u5XRS+gXoX7ujtTUN58jHYrm8KaM4BGMCv?=
 =?us-ascii?Q?cwEEHPP603n3FsOqOZ0znLeagH7jxIRCCF9KsntK94sVXbIEIA1JCToAjW53?=
 =?us-ascii?Q?ktXT8kqLwhG4LNi567R9/oAhX1j3KuyIEQ8dHEi7A2wek8vxzhPhfBphVCPP?=
 =?us-ascii?Q?DVxDQYg4OdHRX1pWdg45AvAuJS2GzhkG3A7/Bsm4s/YstMEBEGxQ7HGYLOFa?=
 =?us-ascii?Q?n65CuqzjBtrQFCBllOip3IbmfJjH3npBnOPkMdfLanlOy/TBMS+hHQ7zD3Of?=
 =?us-ascii?Q?tLo5csX/mnjGIyrUmXYoP3JctWg+fHmoLMwbxgHenGt/mfCYxTwlsRinReB2?=
 =?us-ascii?Q?xImRsREu7iqr3U098T6o/x5DFAACl9T6MbJ/pZAgMFpcaifBu/f368hN3yG5?=
 =?us-ascii?Q?Ju15KW1Pgg7j9gQF9MCcTpRejr3G82p928P84Pg?=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2591;6:i4cvsAtE/vRCpLj2HOJgNIBwRxqlRMcA5j+dUuXs7Uo6bGClhLmKhhZi71dkinAOuwZoXLgRjoOd5hCDgBz36gHAT80QrhI81jofThnXDa1XSIgHV6yuSMTwPtO1bQbIPk8Y7XVEBrkVk9cg7DOEdX3TVBe5OG+60r7FOB8s/FScDcP0BqAkoFIMTyOLgDTn6UHu9vWrWo4jW1DdfOBV1FnAHkTw88pw2Gi87b0kGS68ZwHRU/EFCHcWn45hmmhZTJQE91wSPVeuGgrfVAXpfAnyXUYCcsJA5pz12rRBZwfvGs8PxG0MJDBcJrn9TbeW;5:BQh+w7vc55z2FgJpQSUbkS9ZnuqtYVwiv5jHIFSbEY/XbMJnkpqX7Y0CtGROvMl/H8ynrW+SCaT3NJSqNdEgbYoct12/C32LUAemen6wNr0tUih2KKYSv7ufPCpe/ezT3ajaBojGGPpx0kQnzTm0DdSB2kXWNHTiNn4rNITa4RE=;24:F4/EN3zWQMGsUyPU/2ARa20QZ+4TfFXI1EYeWDwQIFR9zkDQOWl2sV23u65X3uOSe1G1+Q66A7yP+fQREA6zxHq/LScXVrRqR9KlZXyhCyI=;7:nW1i4hD2kb/zR3olCX1gUAeqsrRoEhNrK8E7034OVI/ipJhwh9IYTfWus8ZOXyTIzKcMM/KB/C4v0Dq5d5fttOW5oijsthY4NFn9dMu8gWqeObR652xFCbSWAkI7aR5+QgvYSDURods/MD1dM9ybaUC49p0SzkvhUssYkrNJaA4hc0m0mAdsdlYHAjDdSM9wDwHo+QfVy4feTLcuoNvOetaKEYEkkZA4tj55CsNNv2EZyaftPrgJfHhcWfhTuxU3wdwz42w8rKVDZYUdGvXscOYwnJX5JXgO4Ie3SnZcNm+7gt595o482CUJjnf3ltm+oOJAA2a6OkAtHeApQBoneeJFkO4HYirKPQcVhPb7jHY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2016 13:03:26.6610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2591
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.glauber@caviumnetworks.com
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

On Mon, Nov 14, 2016 at 01:53:40PM -0600, Steven J. Hill wrote:
> On 11/14/2016 12:50 PM, Jan Glauber wrote:
> > 
> > Since time is running out for 4.9 (or might have already if you're not
> > going to send another pull request) I'm going for the safe option
> > to fix the Octeon i2c problems, which is:
> > 
> > 1. Reverting the readq_poll_timeout patch since it is broken
> > 2. Apply Patch #2 from Paul
> > 3. Add a small fix for the recovery that makes Paul's patch
> >    work on ThunderX
> > 
> > I'll try to come up with a better solution for 4.10. My plan is to get rid
> > of the polling-around-interrupt thing completely, but for that we need more
> > time to make it work on Octeon.
> > 
> > Please consider for 4.9.
> > 
> Hey Jan.
> 
> This does not work on Octeon 71xx platforms. I will look at it more
> closely tomorrow.

Paul, can you confirm this? It doesn't make sense for me, since patches #1
and #3 are unlikely to break anything... And patch #2 worked for you.

--Jan

> Steve
