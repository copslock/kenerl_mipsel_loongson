Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2017 10:50:22 +0100 (CET)
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:43303
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993009AbdBOJuPtf8hg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Feb 2017 10:50:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8mvNijAovOveM0HhZn8ygGMXUgB+wKHJoiLP/sIfd8k=;
 b=PyzMll3sFhmzjdG9lP7o3n887l1b8fpp/dJVdcEHphkV8zIHB6lTH2s5aOpbEat3z4wCFTBpCwErfbCDBANB5LqylWiID+/6IJk/MbEziWbi9stXokZBb+UGC3EiXuL2R/q3qtq99eLydqZMjSgJzW3rR2Gp3ix6xiBjuaUzqbk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jiri@mellanox.com; 
Received: from nanopsycho (78.45.162.92) by
 DB6PR0501MB2758.eurprd05.prod.outlook.com (10.172.226.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.888.16; Wed, 15 Feb 2017 09:50:07 +0000
Date:   Wed, 15 Feb 2017 10:50:02 +0100
From:   Jiri Pirko <jiri@mellanox.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Arnd Bergmann <arnd@arndb.de>, kernelci.org bot <bot@kernelci.org>,
        <kernel-build-reports@lists.linaro.org>, Linux Kernel Mailing List
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>, Ralf Baechle
        <ralf@linux-mips.org>, Alex Deucher <alexander.deucher@amd.com>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        <amd-gfx@lists.freedesktop.org>, Hauke Mehrtens <hauke@hauke-m.de>, Jamal
 Hadi Salim <jhs@mojatatu.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: next build: 208 builds: 3 failed, 205 passed, 5 errors, 23
 warnings (next-20170215)
Message-ID: <20170215095002.GF1992@nanopsycho>
References: <58a41194.828bdf0a.685a.3c15@mx.google.com>
 <CAK8P3a3XSBzVoM02sdehxDmrX3qM5NFqTgz2s2hyCqE203VzOw@mail.gmail.com>
 <20170215093807.GV24226@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170215093807.GV24226@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Originating-IP: [78.45.162.92]
X-ClientProxiedBy: DB5PR10CA0012.EURPRD10.PROD.OUTLOOK.COM (10.165.4.150) To
 DB6PR0501MB2758.eurprd05.prod.outlook.com (10.172.226.10)
X-MS-Office365-Filtering-Correlation-Id: 495104d1-0fcf-4f12-10a8-08d4558806a4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081);SRVR:DB6PR0501MB2758;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2758;3:xpbL6bLcT83ceuQIlsIMcjZ681FaVAs7y9zHUlHFwSl0yeFKKfATwTN8+PIW4JODsIR5wYU1lpP8gw7rTKOwSGj4k219/PyYRxbnDigBum4mLMJuCXT90Tc5+Bn/WQGtRqfBGaqT9qXFCrZQeTHB3idjeH8846FuRiwUMCUBCPZVS4p2+BLIjBOMi7RWQ142Nd0YnxF8QBJDHiwJXWMU/w+7eQ8HriH3HP205e6rVhC5CfJK8Yb4riFSdsDSgTzJ5BsCFk0e+2PlvnIG7VKUwdJ3j27yRWBzfPvGUHr+aTs=;25:O3h0D65qhXkC5DB8Bo6+9qBolTz6EC3BicZzPH7kmz0u+Qvc3J5avHcIUeu0mQ3S0iPihFMLixL9VEokyaZrk4SLh7Igd1R1tUEQpA1VTtRgacjPZGH1yQH7FR+m2N8JnInjUV4GU9ZVclo3LTPwj2cKi4ZCweamsegjpQ55Ybo8NtnCEyoItHG3TJ879Npp0v2Z7veKfjcafXnW3Wx47LuXWogzOodSHndBETKjQlwYBBSxySezUtgajq+pp05GPErq3O+WBte1oI3AWcyD6aryYjZdG/EHK6D6KoSNbNo9o+hCqtoSPxY+1L7xn/d7wBU1YWMXfdNAjHJMK+9m70XIA54p0msG+3S1Do3G4/20j4LArHgRa8vlRgLcQoM4EpNvFuq2HXGDYkwPfn7c8BlzfEzu75QFkrKiAf7SSl1IatHwI0awAYYT/l6awWNaHRi443cdSOBh+iv1wvPTpA==
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2758;31:MP0/rc5CYMCleaAlbxwIt1OmmIVv7C4k6csd3Ix3SXlzFfP1BqfsPpgWfal2cSytwkOrQUWhOEpQLfZn+T02lapSEsCU+rhXXFEJHEIjsFzy/VSYD0jh7R1uGYc/XhO0E8q/xf2pRR62zCZ+n0ArLFDdD0dg47dqSWkzz9dhx+R/GyzcD0jOoYIhHqfKyZQvPP4DTeV4o19OrAPCwgR2Lj8kELtVBvrbtARn/jTDKaw=;20:rJh9NG+zb6X2TgcTu7f6n5MLq/zDSfz8cEpZahK5aRcyyxr+o36iDrvGZQulkLT0pP32kciC8vLqp/orcMvuY1yTMhflbp1uQgMOw5LiUzzZExHB59+/DtVESoDGTxcOyaJxZ1J3Klu53RDqi542oqwMjRygkR2vdIBDGUcY6KlDkrHhJJrHygJfDaqjiQXPAPORCuw+D9UL9NQ1uIMxKkoH071Fluyo5Ep62AcQ3HXsRVslJBYEHWsYWtq7bcI9VxdB0Iatw3bfyDZWxZNOsZdi9E/Zz+2oTJTKDKyNYwhsAPiw+4+8CakgvGcS2cirQxoCJt3aK4GIxN5u7Bc3CyE8u+zPl29rt2LnXKXdTPmQ/VLUfCJnumssVc7ZmOkotS50wyltPAD8oRwBzoFSPnIu0k8UdFxetjNLsEtBePsGNUAClys1Qpx1PeCxgUuW/M6FPlGiHML194o9/+1PNpE6fTD+NEJYZmotuBdKEhJFEKxP1O/ljXmqqeJAL0rk
X-Microsoft-Antispam-PRVS: <DB6PR0501MB2758F512B95ABBF9A97CC8E1BD5B0@DB6PR0501MB2758.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6055026)(6041248)(20161123560025)(20161123558025)(20161123555025)(20161123562025)(20161123564025)(6072148);SRVR:DB6PR0501MB2758;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2758;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2758;4:7UsZ6+kH2mEAMgybRUN9lyStEe9yzKAPEYH4h/dKzaNuccxzQYWVEbZMgpaW8ccqY8VdyMXjV8tqZJUXkpsZe7ldlj6KEUIOvTqW2Ns9yYJVtcHnr/gczhbYRWkzMJ1nLhzYFa107pas3HVoqfFGT3VxPVvRZEH8Ez0q195gaBarxHdNwLQ6f/tQ6zX8SjNzHbhmea4q6Peso483Fnql/hdsy64EyaWefoJMFGszrn3ySARjMGnCtf1hHk9inzNec32a6HWXziYSjI4w41j2RvHyyhg+wxtkMqs05BRohcf5K084gS+LkPvBKT23XtsuBrI0VrO7tu/VW4FZZ9K51keMFM/e6oNTRMQB3hopviCGPL0QOQYSLKh5DiqU3EOyr3++dc4tq6Q/pRgZd4OImoh15z99vshjiYO91UIMNaen4KyMqzNDmowrckTXx9b9JG3xybToeNLCE6c4U/Itqpa35VpVW+540bZRm4Zu+K8K4pY0aA+pdfXQiEEWamJRbTVRWesog3jMw9PLFuSxl4ofma7nnq9bb0fFw23QFYApEJU7zdrB426gFdjBP6VI+ABPR8c19JUN3dlBwuuhipp2dZZdYJkYaH+T+ACX1FF+jbbL9nZhZl1eJ/eene19
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(39850400002)(39840400002)(39860400002)(39410400002)(24454002)(199003)(377454003)(189002)(33656002)(92566002)(2906002)(1076002)(7416002)(105586002)(229853002)(3846002)(4326007)(2870700001)(106356001)(68736007)(42186005)(8676002)(81156014)(81166006)(389900002)(305945005)(7736002)(54356999)(97736004)(101416001)(189998001)(4001350100001)(33716001)(9686003)(47776003)(8666007)(5660300001)(25786008)(6306002)(66066001)(55016002)(86362001)(6116002)(54906002)(50986999)(6246003)(966004)(83506001)(6666003)(110136004)(50466002)(23676002)(6496005)(76176999)(53936002)(2950100002)(38730400002)(6916009)(18370500001)(562404015)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2758;H:nanopsycho;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1MDFNQjI3NTg7MjM6NkQ3SzNHTW1tU2tXTWUrWGJ2ZEdPYnRo?=
 =?utf-8?B?OUxHZGdxZUhlYkE1SzM2OWZPQlo1K3hFbEdlYmdsbmsrR2k3TFdMSEFWSXdz?=
 =?utf-8?B?WlF6TE51RWM1QzZudzZyNDZpMjJTcUU3Q3V4cGtmR09jMUVkSUYzbEVwZE1G?=
 =?utf-8?B?VTNnNXVJUVpmSk5idWV3ZEZ0RjZzMllUcDRvTW5ZUS81YjFFS2wzZmR3RXl6?=
 =?utf-8?B?cVBDbDZ4UDJoR0E0S05FeEZLOXJMdDBFbUt3VklJZDBLRXNEa0owNG9ndHJY?=
 =?utf-8?B?Tkp3YWVWWEo5bGN3VlpRdlkrdzV3dzkzZXJaNDhwTVFtV2paMVdCeS9WSVQr?=
 =?utf-8?B?SVR4ekh1K0R2T2U5WDZnMkxuR1FackxVN2NjcDZ6L0lObjRIV3dqZnB0Ti93?=
 =?utf-8?B?VGF0SHNJWk53d3I1RzZKelZuNVNHQ2NySXIycjlaZ3IycmpCYlpDenNLRDBS?=
 =?utf-8?B?OFlodkwxQ1lZd1FUL2paMDdXMzlNLzZSeEdaQzZsTFhOTVRsSTUreE9idWFB?=
 =?utf-8?B?STdiSm5HT2ZSdnNyaEYzUmYrVFA2NEFoVEZ1QkhEbk5jY1BpUE5QRmlzaTRH?=
 =?utf-8?B?RzRyelVKRkJHOThLVGFpeXZnSVRjWk5EMS9MSEx0emU1RHZ5UURnUU02YTJ5?=
 =?utf-8?B?YWZ1VE83YjFtd1RCc3ZEcHE4UEJocllBcVo5cFl0dkZJMEV6U3N5dGNkck5n?=
 =?utf-8?B?Wi9MYzJ1ODRWRnEzSkZvREttMlRGbExUdWt3My9GSnEwTkhsWUZTNU9ka3hG?=
 =?utf-8?B?TkxFVGcwT3h5dEJkaWptRkQrRVZaL0ZoaER1L1VpMFRwcG1DWTRocFpRSGxD?=
 =?utf-8?B?NW5jWFprSEZ6RXFsUGRheTIxSlhFMXdpK3A0d2FYeVlnV0RlV0l0ZnJLOUk0?=
 =?utf-8?B?VDNjbTM0eWREWFJOa2lNYmVQWHB1bmZyNFpMZEZNc0V1YXBIWlowc1BNdVYy?=
 =?utf-8?B?NFl4azBWTmNaK0Zjd041R0ZYWWdzL3AyWCtYVGlPK0FYTnhnMUdtTmUrb2Vm?=
 =?utf-8?B?TStPWisvaFF4ZGNmSnRhSkE5MDFLV2tZWVhyZ29pNlRWaExyQTdHbElOKzRI?=
 =?utf-8?B?Zk56dUhuQzlsM3lIdFFVYTRleE0wRlo3RVJXVU14M09PaGpxMFJVa21Nbnht?=
 =?utf-8?B?eGlncE4wTVRSMnRWaEFTZTZZaFgxUldIa0tjTERaN2JxQ0NiTFE4TjcwUVlz?=
 =?utf-8?B?bjM2T1pnUzZiaUovYkQwczJqVVI2aGt2Zkp2RzhrUXpCZVJVK08xSlYzWU1F?=
 =?utf-8?B?OHFpWnhEcmV5TWtoMlVIZEtwRXUzK3pYUEMzVHd3dll2SjBKS1VidllnKzlk?=
 =?utf-8?B?VHBRR2ZlbS9OeDU2NHpZQ2luaS9NWkZCUzRLUWVsdVlyOWliU0dMalltUXE5?=
 =?utf-8?B?MURtOE94TnMzU3JnMHdMNlg3czQ3YlYrNEc0SEF5VlNBamZFUXVNeUJPeS9M?=
 =?utf-8?B?dGtZTzRQU2dZTTBpYitwSGFHbE9makh3c1A3bDZZQ0xkcVJ5ajZjMTRSMDIx?=
 =?utf-8?B?OGFXM05TclF0YnNnbTdkdCtZeXU1T3BsVU9qR0pDWEl1UTR4bHJESzkyTmhm?=
 =?utf-8?B?Qkh3UUY4SFJhODBvdytiQjNDMTFKa2QvWGczL3BtTTVGU01INnNGWmlCdmFj?=
 =?utf-8?B?Q2FSRmovMnBGaHZFUDFDWEhtdkdJV3UwV1NYaFNFTEpyMms4bjNxcndXN3pB?=
 =?utf-8?B?NjYzVTFqK2RMMXc4RFlsOTB4ejEreWVlYnNKcDhocURsZ2dCTkxqWFhiOFN2?=
 =?utf-8?B?SzZHOXdSeVpHNUIzNlorTGN6WWVsbGFYa0hMWkNnVmVQRmRPK0ZKTklSQ01z?=
 =?utf-8?B?MDRoeUl0aVdEK0lvN3kyN1k5bjNWd2ZzVmlxTjhrQ3Y4RnBsL1o1aW51UTBD?=
 =?utf-8?B?ZzlKYjVlRFo4R0UwV3JzVHZWMTRKa0lINHVjVkFBQnhQWTV2MXdYNi9FY2dz?=
 =?utf-8?B?WVd5VFNMZU9lRWRkS2hvMFRzWEptYlMyTHAraWxZeEdVbHhFeXh1YVhHa0NT?=
 =?utf-8?B?eFJuV0F1Snc0ZDFQOHpqSEl1MUU0ZGtnRUVSelVFV25QWXdPenNoejBtV3M4?=
 =?utf-8?B?TXEzMjVpZHM3R2VhZTZoTjlEQjAvbDlzZmpmTWkxcVFiR2FnUVcrK2V6cWV0?=
 =?utf-8?B?TmpOZz09?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2758;6:eU865plLOzgvd7tqolfpXQN8uJ48H0r0jsqVylWG0h9QP+FXBnSj0wNJj0jqLfa4AYLH0M72kTZMSZ15mtDogE9taOA+dnzakt3lZN1Ug+wpV3uluE1VTnkfYQ5Vvs/DDUK4mjpYtU95sNnDJdVA+V/8lQrQwNCNs5oBqQ6WBqovxIEI1i6o20SnW+TW0aO8VbPQE5SRUdTq5wW6TqFVvYCVfaoFv4slKdpUwiZEtyhVwkucsvusb8x9tJfz8MMd7/hH2+edQ+XTZdvTxp9HJ6nGjsmyAYcXrAhQ8PGl7eMUPFQzvW2D1qBgTr3uAVAVSDcG0/B5VD2iNOzBN7o1VckDW1DOZw5LvH0vHl8F+d3eOi807+NXtRNbaLOWuLldgBVdXLyC/mDaOGhEUTdXzNF45dJ6tHe/R6tueaE+M7k=;5:O7OBcmsEehZbqoYms7cAPvZrjQkiLvXFHKy56bGb/muFBzCNFO61B/mQQSKipte39JYgvVruFg6cmwaZALUJUBasHbN67q5R2ECUzIPYgDomtZ/mcBkKRkR6YGagmrWteiwKYZUpAkjnalEO31A52uLzbHoJkOV6yKRiiqlBTUw=;24:G5CJ0imn8+eysYLhXE6a1X0MWaJewOA8jr2HVT4docsSfB+EW9q0pYu/laYak8/bYGEWXHoPMYBdhjBh13FTScxBK2oHS05WKIz7QUAAzZQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2758;7:7tR0YNyNeB44bM+cVkAjqX8y+BD8awz+t2i1iC4PljxupscrxDsDxFVm+vyrBwWm6Wn1Tod8aBYmfK/xgQiy2sM6+WWagikZq99ogVfujPSceqwiv/BdOldaIlCJH68umnrinmhiy/JsVRcmC9c37M9Qs0ftC6aEVP8LrbnZqRly/M9MFHBFL1dUGljVHAIrGIEDcTGLNGesoIXtF+LODFkel0c+p8M7pbYQqkvO32ITSRXUt/WCa2zCKDFEipkVNB3oLVW30Ts7qzVIsakP5LFdumhcz/3z29CJezLujjI1OAi4IcGQADe/v59/I9GvzvN+dki47PX5OaJ0UmsY791pGYaa+hb/eI4PZH4puPuUR9ggtlrTgOJ3EU80N48uc5yQhUNjV1eNGQiBlyZZ7pyk4MkJ60Ny9eanUi2wVIFZ0S9n/nIOnh7TjHe4KNvyhIUMEO+k8vJ0mKLmKrgCCKMB+1MTIhMwEvLuABNNIE3afHajGhGAMCBFIf/ICpay994d+o7bXLXvobwF0av91A==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2017 09:50:07.2824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2758
Return-Path: <jiri@mellanox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiri@mellanox.com
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

Wed, Feb 15, 2017 at 10:38:07AM CET, james.hogan@imgtec.com wrote:
>On Wed, Feb 15, 2017 at 09:56:48AM +0100, Arnd Bergmann wrote:
>> On Wed, Feb 15, 2017 at 9:30 AM, kernelci.org bot <bot@kernelci.org> wrote:
>> > bcm47xx_defconfig (mips) — FAIL, 1 error, 0 warnings, 0 section mismatches
>> >
>> > Errors:
>> > /home/buildslave/workspace/khilman-kbuilder/next/build-mips/../net/sched/sch_fq_codel.c:468:
>> > undefined reference to `tcf_destroy_chain'
>> 
>> I have not looked at this one yet, appears to be caused by commit
>> cf1facda2f61 ("sched: move tcf_proto_destroy and tcf_destroy_chain
>> helpers into cls_api")
>
>So effectively CONFIG_NET_SCH_FQ_CODEL (which bcm47xx_defconfig sets
>=y), and just over half of the other packet schedulers now implicitly
>depend on CONFIG_NET_CLS (which bcm47xx_defconfig doesn't set =y).
>
>Perhaps revert would be best since the change looks of questionable
>value to me, as all the users of it are in sch_*.c anyway.

Fixing this now.


>
>> > ip27_defconfig (mips) — FAIL, 2 errors, 0 warnings, 0 section mismatches
>> >
>> > Errors:
>> > drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not
>> > satisfy its constraints:
>> > drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler
>> > error: in extract_constrain_insn, at recog.c:2190
>> 
>> broken gcc release, apparently fixed in gcc-7 (can't reproduce here at least).
>> I suggested a workaround, but got no reply so far:
>> 
>> http://www.spinics.net/lists/mips/msg66465.html
>
>I'll look into that.
>
>> 
>> > xway_defconfig (mips) — FAIL, 2 errors, 0 warnings, 0 section mismatches
>> >
>> > Errors:
>> > (.text+0x14e10): undefined reference to `physical_memsize'
>> > (.text+0x14e14): undefined reference to `physical_memsize'
>> 
>> Hauke already did a patch in December, but it has't made it into linux-mips
>> so far:
>> 
>> https://marc.info/?l=linux-mips&m=148612428414708&w=3
>
>Hauke: you mentioned sending a new version of this patch. I'll apply the
>original patch for now, as looking at the VPE loader, zero doesn't sound
>entirely unreasonable:
>
>/*
> * The sde-kit passes 'memsize' to __start in $a3, so set something
> * here...  Or set $a3 to zero and define DFLT_STACK_SIZE and
> * DFLT_HEAP_SIZE when you compile your program
> */
>mttgpr(6, v->ntcs);
>mttgpr(7, physical_memsize);
>
>Cheers
>James
