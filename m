Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 18:11:23 +0100 (CET)
Received: from mail-dm3nam03on0074.outbound.protection.outlook.com ([104.47.41.74]:40322
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990924AbdASRLPm1PM9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Jan 2017 18:11:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fkqGoIUbE80/DMV+G6ZLy+yGd8pBgbqQXdPIlIbfwQ4=;
 b=F7EiV9i6zniW2yDkR7YoVUbBoomNUs8XPQZuL/iLtR3ms+opHszyQ4WdRVJPnW7NDxC/XPD/VIpwNmDTB1aK2s1wVOzV/pHxp2q9kc5b3BVx6/mv5dOZ1ikMwl/AJzPPWQAtWMtyFz1pJnmLZNUSeA1cFokRa6fyzFf5oRSbvZ4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.860.13; Thu, 19 Jan 2017 17:11:07 +0000
Subject: Re: [arm:phy-cleanup 10/10]
 arch/mips/cavium-octeon/octeon-platform.c:1064:15: error: expected
 declaration specifiers or '...' before string constant
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
References: <201701192138.NZ3q3lNY%fengguang.wu@intel.com>
 <20170119135452.GY27312@n2100.armlinux.org.uk>
CC:     <kbuild-all@01.org>, <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <0605309c-5e79-ae31-8f37-bba722ba8354@caviumnetworks.com>
Date:   Thu, 19 Jan 2017 09:11:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170119135452.GY27312@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN6PR07CA0017.namprd07.prod.outlook.com (10.173.33.155) To
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11)
X-MS-Office365-Filtering-Correlation-Id: 839c12db-b2f9-49e3-9b7d-08d4408e291b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;3:V3ZJJgz8z/K+njVyQ81/Qay0ZSUJwhewHqqoYZdtzcyyYZ9jrKXOCMO4joGbWubimvopgnxI+8fy/EeEVlkwDSEEzHX3+zJNivruOQrj5jw5RLQDOTnsG2EaxPiw0B00AQEtMoKP6kG7kSUE2DVUtt/NgrtTM730VFBxdJlfz3AU0ePOEULu5yomiQpeSWthyRpb4cTllLHzb/QPPQbaEIJZiqr7IhT6hU98Yfqs542mARAz+ZPr9X/8vsSP/BOh1y1B8nRziQwXfb4M4BQHrg==
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;25:b1JXrSSYN1JYlV7eh6QiGwH5tMXRqPpJoNPfAAoHFxoWvo9fhzkkoQvdoM7IVgIGFuMaRHRFGiLqvv1ALMF/anGBnOBeZawibzRUHgB3J2xHn8KA+uUh1gi0FW0JHwlS3BKF+Zsgzo0eRXk4T39eqQxPAkrGO5N3z0VIbl84N4rsPHGsxkmCHcKP2Ccw/LSm1KxsL1Rb2kEIXb1pqk3RvQfL8Sv407eMNZph6cPmevmEtq8yxNQc/0XFmcN6XmF0OCofTJnAO/zCQALTWw0mP7aOrfp2S9nbar5qNW8F1DKBVEwSb8PRlno2apN3vN8orRNc6eVfCo4treGQPE330sQFIc3JjTXw4dF1B6I6TJERyfdkhYiQsj4g6d6hShWwZKvgdnkMfnaJzNBLsm6m1fpiDDKQIzuz0ggT6GyAbeBiswFZySdPP44fxTOV0PbkE68osRjWkVH6wKvGhbZkzjgLlLsrfMnuh3I6u5q2/VAW8ExD1HSFu7Owz1I+Jt1gnkXAy/pY8vZ6wCdZe7ha2Of05OuoxUdWeQcLdjOyuElzjF4Se+rKbNZTVsV6tVpDYkhhy4bne+VAm5FyIF+M+xz//hoFVm9sOpyahkAzciTLJm+WrRyeBb0b2pVuzZRArW9YWDeWAO9p//gJtUDPGgWI065M/impYogjc6KKJJ4a+SZSWPXODbcmEY4osPBAgVE1SU80u+oKKJHxDEMujh72Cy4A5u8WycatNxa6Vf9bAVrsEZKTE7twdBY9DJ6pHOvY5zMJhqn40BR/S7ILviRLd5yaMOJ4/b1Tx4P7mfyRru/QIaabPT8r2bQqq1Ywi39AoI5cOazDaiEpcIkt+nnG5Z0cR6+np5ghKhU2aHJ7RFOCZnAa39/xmxU5AaiO1RgxOv5eBHMEhGYEO/JO9ODc61ZqJ9SdvOHN5FcRwRs=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;31:b6LYRwbV9YcuelCjB04rTxWDV14W9xBisaoECXPIBP2c/M2RsNqRB3dAcfWEa7O9nmMRo2B35AJKP90fv1OsiBPtR3YD8EHUyt3UF+EsomGrUpok7VlHZ36rava/Lqn8NWbv+TTPG2U05pAdfTX0915NgH5dRdvc4NcJh9X794HQZoHQSEG9AqqG6RnphdcYYLqQTbAC0fexr9KjZbjvWrJSnoR7QtuPbqt8JU5U7/3MQnn0JZt/fPSsy7vSUbG/ZpntgRLEdoZYXvxYvtvjcQvMCALkFBBpYRP+0IywHc0=;20:0kXoBCeFa+P+PJCum2FOmObSYWW9tIVVh+1Dlfp7KtAYRl8mPhkQkCTfhQK1pPjKtB9YMuZELGh2HRSZbID+e9mNPyWK6CWNc92WYTp3u+rhkwC5OumGGVSURmlqQ/i3NUGDPoMfl8mvBf+I/Yl7ce/ONWX6hDdeOYj3/1KWjAUlQIhO5g9EZCUCGygrRuqRTs7VfEjmoWSfn6F/hz47UBM+D7Poik/7WOmdxCxqC5hUHPJvExv9m79HHjhLmAbUVOL/rkVRkf/EXLpyOjxV3W4zkcfRWYbazGvu7WpKlpU+z5lFbowGMeVrB56VMKWM3Y2pwa1O5T9o40WC5JKCXRLGPGar62DtW+rl8s+U7mK8jhPZnVdyZtGRi87XWGjoVtjK/6lElquKT2DWA9I5Mp5a8g1hOajwayJ113a0PhwCxDNK8drrVs5wlqnjCySGUc6euo/IAmDEYyFldlFcS4UXCFw7GYuOZmhNT1J5foMUgZwhGMpmBgVtHWaldn0FfwaGovrIVqL/hlTHSSy/Tc3Z5XCcIg9tCPk7npA+Xk2EbKCMgaJb1fj+MwzXgzL8MmlnOhrBgdrxADtJz4IhA66bRvwFI8PEldkJrkwdMwc=
X-Microsoft-Antispam-PRVS: <BN4PR07MB2129FC219724948451C726BE977E0@BN4PR07MB2129.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(162533806227266)(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123560025)(6072148);SRVR:BN4PR07MB2129;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;4:Ncf02mdt2wzLvirXjow8TZ8a8CqBsiIK6B7bmcu/6Ey2hFtMqNxxTp3F5i4P0O5DPW1y47/ayM9HG+gEpM01Prv4kGasF7s6jQxq/idcIcmcm3iBF3Kzk37afqVA2d0eub6P9RPKclIfxEXp/ppJcl4nNMgwSJ0rz4S4b6Zf08L6tpvCCuHrSVFsQQ0RSXw3qFt02H/t5nn5l6pTj9nvU9hSbiaGz/vAl708w6GSjUlvhyg70uCC4Jr9YJY0vCV7fKhpoSUgXnjeB601VagUrHqHpMEOsc/HXdXjfHlkxrnU8cIFZQ+5eq7nWQ4T0Ij/BipmzI3H8WZobc3L3si5o+GgmA93PUBOwMFVLQmywiyHwQM1OtO58BswXyb71RZTePxNBGneHM9pfKAJ+wOL4+m7E6ppujExUR84BPQQfDbEUNjtQoE+2HcH+q1WnjhIYJcrU3+k/eKHSl3xEyVdu1hbTyjk1xPpxEJyPzFKSzuxlh+LTRgnCQVB6RXOGAY7h0vJHzyL6LDrKEgDOCVxLyY7d64bmFBCbIm267LlPp2oIvKIMCZm7tjrXkPrtkggzfgs6M+TqS9lrmRSf/lzligKeSOnP/1tYTes+1b2QARxt6qJ7i20Sviz9hJ0DMIPXQseII9uJ/9MyK5uvy896g==
X-Forefront-PRVS: 0192E812EC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(189002)(377424004)(24454002)(377454003)(52314003)(199003)(23746002)(229853002)(54906002)(38730400001)(39060400001)(92566002)(81156014)(81166006)(6512007)(8676002)(6306002)(106356001)(575784001)(25786008)(105586002)(230700001)(2906002)(53936002)(65806001)(31696002)(47776003)(65956001)(66066001)(3846002)(6486002)(6116002)(6506006)(4326007)(83506001)(33646002)(7736002)(101416001)(36756003)(305945005)(4001350100001)(189998001)(5660300001)(42882006)(110136003)(6916009)(65826007)(64126003)(97736004)(50466002)(50986999)(2950100002)(53416004)(31686004)(54356999)(42186005)(69596002)(68736007)(5890100001)(76176999);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2129;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BN4PR07MB2129;23:nb4rWbmaEHEPgyQuT10iYwtEok0yo5wlapwc2?=
 =?Windows-1252?Q?GOhsUCIbyWpvr0t3uQRH0XepSn0BG+N42ufQq19qwaEXo82BqXe0rbBT?=
 =?Windows-1252?Q?kFSSsRTCKpE5OseLnd+koC/5cJbzNy1NheVDtbhmxFSE9Jmyff+hYFZ0?=
 =?Windows-1252?Q?MiiGc0KVdqtO2rKO8MXkZTEKHmyUFBJZz8y3YoO7OuH60aew7P4cJYQ0?=
 =?Windows-1252?Q?EJfCt9ZajbTiNhCy7qkACZI2osoHF7ENkcLdom3GVGc/RQvEjYxIfuNw?=
 =?Windows-1252?Q?vJVcaE156gWTnqNhge8L8x2WWd/TKmY6rNPs5eBmy8xXELMrn7FCgaRX?=
 =?Windows-1252?Q?XBbmFNxovypj/4NuPMDL9gnVLpiDZ8fNgzDfECazAm/3BL0HMyNHUr+t?=
 =?Windows-1252?Q?j2PVdztcyCm10wCy99IYy3nW5ezxMjTcySbPizmpquFjimiJcZU0rzop?=
 =?Windows-1252?Q?I62w30iNUJ5kZtM+Znob/iiMYNhpXYPCRVuq4MvYudNVHG/AzchDK9K6?=
 =?Windows-1252?Q?AH0Mw6/wfs1vci3k4RZ/iEJ0WZZbQmp+wzCGRmLvyHJLOVVROHi1+zb8?=
 =?Windows-1252?Q?cSCPVOvBZ2ltVxWsTnNzNQyDqzRZqpgn5Yyqen7Dhc7cYewu0D74lGcZ?=
 =?Windows-1252?Q?KEU2CfIXPPGZpweTaKtdItorHOd4I/SCI23RQxxoPkGz24WHCbhInmSe?=
 =?Windows-1252?Q?qJSC9R0imwUXk1luXgEFoBkilN5pccU8i7xbCpLPv/MQa79DNiEIA/+9?=
 =?Windows-1252?Q?QpyALhhwoZIYgk/iy3ZVhmEa7vVdHh6CO5612Zxne+j7bP2ZtANg/PYL?=
 =?Windows-1252?Q?LLqe6wWmqzKt4tvoUtt3N/o2PFxYbprml9tnj2iJJYXX9jWz/yL5XMU0?=
 =?Windows-1252?Q?OlBilHT6dyl1Lz7Z7z22rf/Hv5yOAwI3jzrqEfaMBi9LnMXdnW4q07oV?=
 =?Windows-1252?Q?7vd4cFTROAixyI45ziEpw4JlycfklHsncowUn+6s3ZDpipMz+H0jeR/1?=
 =?Windows-1252?Q?pkl404b6nEWv3RTpB8WJoOrtNBjk3ymfbyimnjM6oV3Ula+YIy1x9+v8?=
 =?Windows-1252?Q?6MGr5hMl5pA9lVhyMoGR9xg7j8dqz09sWcwX0NyvjV/PNUVPn3N/52vL?=
 =?Windows-1252?Q?wFFQC7RQn4F/9PPrDh0xCalHEPEWJ5sSOrCKLULfFzET8Ef3R6t4tPte?=
 =?Windows-1252?Q?o7YqOyNpnyV2xt4eXQCHXAMLDv6RfZbzfKyzadqQKzRubHqznPzT/eOi?=
 =?Windows-1252?Q?Ff84JyTXENOTZopAxZ1tZ0ZBJ0peta/RyR0YRYCrD+VIa9BrYmX4Ieva?=
 =?Windows-1252?Q?ijzTguGMhV0MXRoP04qBIlyPF23xmDYiUXVYZrAvEBLG3NbhkszZB+DU?=
 =?Windows-1252?Q?FPdG2W6xpvZniQ6AD0HxcKJ+zNs64P6akuuexCeHtntJjSb1JE8Mj3Dj?=
 =?Windows-1252?Q?Shhh69ShV4ptzPu5WTsCYq5YOSheSvtJdr8li3++HxeSkWGCSkVSfcns?=
 =?Windows-1252?Q?wmqfbBRfAx1AkuPYFRjtWMtQjdTK+643dv35iG3ooQ2YpRsil0Hplj6C?=
 =?Windows-1252?Q?BwJiC6B5DFal1Q44ou0qUSpBiLk9rXU22xRD682RQcXLewgjFg1hUWuZ?=
 =?Windows-1252?Q?OIUXmLxxPhCqPrnEkhb6yHgOTl1ouBFVvlKH5QefUYp?=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;6:Mz/2qqbMRoL+8CoWHeia7+TY2VDhX09dfEvZZGSXfMG+JYwkmfRMvXKWHLN4COYgg3KR2/NOuROyFg0EkiczSNGfZwJi69EjJejTo9FsCsmkzFSKVF9+jzdkcK9a04xmw6FKhME11xJXW0sImnKk+xo2BYv7f/Vgw0hQ5yLlToEoE4PB697uqnKb4A2vPSuws3UTKZlGv4bW0Xcp92mGpeDdnSHt73IeydDnFEAyqT06SDEKimoEtDCxUc75Qbu3Y4DiLWxPMY/ELyhi/SqyrE69o1ik0ToYuwqlXM60H9VZepcMXOdaW2O3a50ff32wOam9iSJiqVSvl7hxoZbrt3nbzbHB4GNvodWrnF5XD8+ciOST1KbWUjRVh8+CqdAs5wVNUWsYJK65fBlVt74TYOo5+oxtlFLxlY2Q0vDOQIc=;5:Becl1ENCZAZyAYVBN33++5c3QDcUs8k/wreOKV+ggmnUffPHNiZw5pIQNe8YBjz1F+fUVKxS6Paz+uujGt2+mSPpuURSl0J0m/RSGQ+nbBePrXodvXpE5cy2tGSg3OlArFA3/DIIHLrLycR6NzxNWw==;24:egZuv9LYPWZDMjBMS5X5/+iw7GZQnBwemkrIlpefBG3oHh6lZ5G7asJGILKGbp93OfhKs/Pw0L86jlMs2ctVI/dg1vFnncJ1lKuHIN45XQQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;7:zz518nW8gbYmYMjJUO0no1jzCS7H6otN70s5dwdpq8GIzypsxag4T/KuM8lJQFZvoEXYB+m7Q0/7wCK8Bi9d5/oz60x9svKbAYS6EFGG/OyUpBlVhoHx0h7ged6O77O3MgNGQqnEwBZEmy5APPHEx8qfVJisVORRF253xqqZAS6bhHvBCEOP4zyAX8uyDQMdE6w6lhs/afJ1V20qre/pDN5oKPTagCSPqG4yOeuN7i+r/aFh0e2fDjc9GoIsoKWHz4tV1T3DlHfNoV1fFrHZFIFbrQlAnLTt9K0gkXQG4oeyl1tKK7MfZer5JcNZFkDl+L/MeaX9igpD50hRDeQFwvFr1Z7xHMipa3w3rA/XtCYNWCuHLnyoVUuA06a6WvFEuprDB8t/Gui7qGWH8wFrcbh67b0GQwHb8Ez1Y/96uuyXWL4BCRBQNfJA+ci1OYoN+syLXm1/+RTi3V3bwFDLlg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2017 17:11:07.8916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2129
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 01/19/2017 05:54 AM, Russell King - ARM Linux wrote:
> Hi David,
>
> Is there a reason why there's these MODULE_* macros at the bottom of
> this file?  From what I can see:
>
> (a) this file can't be built as a module as the Makefile doesn't allow it:
>     obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
>
> (b) this file will not be functional as a module anyway, because of the
>     multiple *_initcall() statements, each of which are translated to
>     a module_init() call, each of which define an alias to
>     int init_module(void) - and that will cause a build error.
>
> Can we just kill these, rather than adding a linux/module.h include to
> this file?

Yes, as you note, this file cannot be built as a module.

You can add: Acked-by: David Daney <david.daney@cavium.com> to a patch 
that removes the offending MODULE_*

Thanks for venturing into the murky world of MIPS,
David Daney

>
> Thanks.
>
> On Thu, Jan 19, 2017 at 09:08:42PM +0800, kbuild test robot wrote:
>> tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy-cleanup
>> head:   ef8cb7d5f838770f22cae0e20fee8d1157fc88fd
>> commit: ef8cb7d5f838770f22cae0e20fee8d1157fc88fd [10/10] net: dsa: remove unnecessary phy*.h includes
>> config: mips-cavium_octeon_defconfig (attached as .config)
>> compiler: mips64-linux-gnuabi64-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout ef8cb7d5f838770f22cae0e20fee8d1157fc88fd
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=mips
>>
>> All errors (new ones prefixed by >>):
>>
>>>> arch/mips/cavium-octeon/octeon-platform.c:1064:15: error: expected declaration specifiers or '...' before string constant
>>     MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
>>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    arch/mips/cavium-octeon/octeon-platform.c:1065:16: error: expected declaration specifiers or '...' before string constant
>>     MODULE_LICENSE("GPL");
>>                    ^~~~~
>>    arch/mips/cavium-octeon/octeon-platform.c:1066:20: error: expected declaration specifiers or '...' before string constant
>>     MODULE_DESCRIPTION("Platform driver for Octeon SOC");
>>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> vim +1064 arch/mips/cavium-octeon/octeon-platform.c
>>
>> d617f9e9 David Daney   2013-12-03  1048  				break;
>> d617f9e9 David Daney   2013-12-03  1049  			default:
>> d617f9e9 David Daney   2013-12-03  1050  				break;
>> d617f9e9 David Daney   2013-12-03  1051  			}
>> d617f9e9 David Daney   2013-12-03  1052  		}
>> d617f9e9 David Daney   2013-12-03  1053  	}
>> d617f9e9 David Daney   2013-12-03  1054
>> 7ed18152 David Daney   2012-07-05  1055  	return 0;
>> 7ed18152 David Daney   2012-07-05  1056  }
>> 7ed18152 David Daney   2012-07-05  1057
>> 7ed18152 David Daney   2012-07-05  1058  static int __init octeon_publish_devices(void)
>> 7ed18152 David Daney   2012-07-05  1059  {
>> 7ed18152 David Daney   2012-07-05  1060  	return of_platform_bus_probe(NULL, octeon_ids, NULL);
>> 7ed18152 David Daney   2012-07-05  1061  }
>> 8074d782 Aaro Koskinen 2016-08-23  1062  arch_initcall(octeon_publish_devices);
>> 7ed18152 David Daney   2012-07-05  1063
>> 512254ba David Daney   2009-09-16 @1064  MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
>> 512254ba David Daney   2009-09-16  1065  MODULE_LICENSE("GPL");
>> 512254ba David Daney   2009-09-16  1066  MODULE_DESCRIPTION("Platform driver for Octeon SOC");
>>
>> :::::: The code at line 1064 was first introduced by commit
>> :::::: 512254ba8383c5dd7eca6819d0da1ce2fe9ede47 MIPS: Octeon:  Move some platform device registration to its own file.
>>
>> :::::: TO: David Daney <ddaney@caviumnetworks.com>
>> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>
>
