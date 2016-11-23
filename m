Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 13:15:46 +0100 (CET)
Received: from mail-bn3nam01on0050.outbound.protection.outlook.com ([104.47.33.50]:28320
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993008AbcKWMPjiLXuF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2016 13:15:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Jnv7Zjv4j2nzxcomswZoJ4NYUCKFDwc9phbTJLFMWNI=;
 b=BlAOvRoqqQ8oohv5dEq4igApSeG2k89zfzwwT3Y7J5z//tGRU7Ezb3vKCfM1TylhEyEqVMxYBsjvognxKDmkEXlrSTIARr0TDTXToIzec3ApE3FhZqmHcH7t1VSXjWiMYIuIOfkG0paFO0i9BaTBBI/+nK61A7x4fp+P3mZ0j5k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 MWHPR07MB3215.namprd07.prod.outlook.com (10.172.96.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.747.10; Wed, 23 Nov 2016 12:15:31 +0000
Subject: Re: [PATCH 2/5] MIPS: Fix vmlinux.64 target for CONFIG_RELOCATABLE
To:     Matt Redfearn <Matt.Redfearn@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
References: <6f8e21bd-ca22-5866-83dc-d70e4e10842b@cavium.com>
 <9FCBB1D1936B2F4DB2DD02BA3957FB504CF9EBF8@HHMAIL01.hh.imgtec.org>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <a8bbc895-6069-a14b-c5de-52af655adc6d@cavium.com>
Date:   Wed, 23 Nov 2016 06:15:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <9FCBB1D1936B2F4DB2DD02BA3957FB504CF9EBF8@HHMAIL01.hh.imgtec.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: CY1PR05CA0022.namprd05.prod.outlook.com (10.166.186.160) To
 MWHPR07MB3215.namprd07.prod.outlook.com (10.172.96.149)
X-MS-Office365-Filtering-Correlation-Id: da3277d9-ed31-464f-8a70-08d4139a6be0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:MWHPR07MB3215;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3215;3:aI6La8hRDYmRw1wd0jmZo2gH9coSDLB/0Ma3oGBoAbVlkGUomt9C/dJFL+B1EAFPyzIE9oNTMwkK97ziHACQ74Q1sxgI4LCQvGRjPhNnWIsG/cpSxziiWa2CRZKVz8yDdIZMt26tl/siaSCjE+/M4McfjBax589RkMC/bmEdajHdDwtz46enRw4gkahVa9/MW2NNhLjgjoB7W60h9GSZXRoNbILarU3Rz3FnUCdC8nLY1X7GI0L5DhlwpgBs82E8veNbaAVI5BCFRDRD71kkvg==;25:8EWSlQau6WXAQ4POtGfZrd39fHEACMpZxTt0bKg7r98nEBJllQA3orjSN7Tp9+LF2zbIG1RUAazylUD+x9A22LqSeUzTm27aNxEZ0ZF5Bn8Nfk6Els1yHWmFra/aTy1BbYrsv7ixR+spnusbIGZkpuni+puaRmHDQ0qGX7GAQjMTZYnq1HSMFqbby0+zYkFVSCxgA420mWbfWrueIF13LkhHfmz+HhMFwVL8KaEd0fc/Ocz2d3AzgNxt+CRTOTj0yuhaOQNaEgQcGA7V2m56MqBEcBlx8iiO75zPlCk/386O0+zQY2VgmqHEj7/3iCUJn0+OBLE79twEF6BPXDxQGZWeSpn/4DG+T/gm06BgzRGwpSR7CC0ORYo9wdbZmviTRHVXlkLWdyv6BznOT33eDASnh7bSVp7yTvgnevr+oqAtar1wchcwaYp8ENshJIi/gcOKZpy3CK/C+m/UkKSowQ==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3215;31:gZHc8/5HeXfjkAb+noGM5LeksIKfA1JrAFnKyIklZn9BpcCVTJyxU5wmtqiQjLgi8QNaueLGs28tXnMzQD/Ly4sGU2O2sDXgXmGXwfrByuXxNhae7LmzGLM4rgJMZedTXJxmGejLqxTRkszSifZcSLTKtsiz9LVWko1RznLZG27W8lO2JdQfcdfMX0MIJBgHat6zQMOtxI4infcA0kVhuD6IM7cwiA8iSYxv0uiRfJUPX9nH7UOxzPdxbAhnKvStINc2UXjqD6eHL9uo0RqXbA==;20:lIYOM76q1a5lb7LH4Q++dps0IQxwL104j2kXec8rLGggfAyiMcI74jD/Hv228Xb9o67DF6MgZLClrSbgEWz1hAG4JeQ/J9ygYR00Xe6uWKSKLB3iTByPq0tymjb0WAP75K3yZp4gXc4mOKrQjwsx9bee6eya3dVLxib7VR9I2FLTQfYBnwJeRIZ2CkijVSt/LmZpGUzkc6kGH1quz+fzAjUeaVDsZSoq/KjCoq6AUYSSc7UZZ9g/iUjDA9dlXoqvEnGdadG5a8J+r7Hx3xyL5d3u2LBioTzgaAiM4CNV/MKre+WLE7OoOgssfePmkTklMBTH7QDQzhlGVulLFcj7eXJK1s1186HSf2qchRORxNTtkekE/HBtfo7nb/cdYeXKzNY0sogFzuVxqxaXrN0oex5vwGkfzzenSfJgBfnbmmMe611mEVcIOwdNHHtaoKB6XzRh64HEDWDGonMRQfIqNYlyE93X5Q1VwkUtZrLX4qo39/Nis5ZcMnzukQY/X6bk
X-Microsoft-Antispam-PRVS: <MWHPR07MB321575657E88148D7E1678F380B70@MWHPR07MB3215.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6060326)(6040307)(6045199)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(6061324)(6072148);SRVR:MWHPR07MB3215;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3215;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3215;4:lhiH86mXW9/ltV0FTsy3xsLwOdarQsqz+DgMJIDR7wZqM+Bnb/X/nwwmTD6qdbByjvwBJAmziDZMNrs3NHtRUx6KzTTp+xavV1zqpTHOBOwfNef42iwpprfegE7V7U9p9LcuS2XVDCOdziwyu+1XHzSA1wSD2IiBsSmUVb6ZSR70kZn2cxn9ycDxRAqn9c1l/TJ3koo+S54khS479gl5ipz7/d/orW1cO1K3gJeHWzOqvVteGo941XZTNEwdld42E1fs2TgkVvDowFhwxH4Zq4XaqK60cVpXa+dW4pjLU3vZnzJ+Ji7Tk1E+KEozGRvbrfbpnmAEVOq3l4f0y8X/NVdV8e8KSrG4plnJRETngxbmBfENEGMptm4Z4WEqwMqWwNxzlF/zD82FnuPEKpzuoj1ZtVbHbZfsW2yiitqqvZx0/XINoakxNqjlm7TZ0nLLZpQiCHpaZDDezHmZ8qahjQFDT+ATAPuYRMtnM261ukqT9UuED+wBsiA9fFXG7+r2
X-Forefront-PRVS: 013568035E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(377454003)(199003)(24454002)(189002)(50466002)(76176999)(33646002)(6116002)(97736004)(4001350100001)(101416001)(4326007)(23746002)(77096005)(189998001)(230700001)(54356999)(50986999)(5001770100001)(31686004)(3846002)(81156014)(36756003)(81166006)(42186005)(68736007)(38730400001)(8676002)(106356001)(105586002)(229853002)(83506001)(92566002)(64126003)(31696002)(2950100002)(47776003)(6666003)(66066001)(7736002)(65806001)(65956001)(305945005)(7846002)(86362001)(65826007)(5660300001)(2906002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3215;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;MWHPR07MB3215;23:cVEWFTxPU4eD9kDv2obl9nkJnSnWZEQMSVIkl?=
 =?Windows-1252?Q?lVsOw0Ab5mZkJi3eWhHtq1qNRbGm0w1FmLnmNBoiOLA5DdaCcuY0tt6O?=
 =?Windows-1252?Q?FtSOJ1iNTGsgKmUqQWWEtkbzQew5Oj7oyBLC+FobgAQz/VzmrrZ5irOr?=
 =?Windows-1252?Q?0FxVWAS4ijbA2zuX0bOOdurkv2u2XH8teJtvnBUwn+L5stJeZq+iTyZ6?=
 =?Windows-1252?Q?O7mUhlbVOPZutFGC3j22XYa9ALUibY8xeLmquDAlxMLzDm7LXKcN6zfH?=
 =?Windows-1252?Q?AiWdt1u3nYepZzHV4QxRdn2MgvTOMhVqsU58czleeXnAXdyitrldN2W3?=
 =?Windows-1252?Q?AZkkjBXC7NiVHghBufUyydEzbN0Qi+wjzeZEiwcmuf0rBin1AFkEeW6q?=
 =?Windows-1252?Q?WISYNblgd+QaAaFFjvZApkGX9QAB+YpmkYts4fxlGG6FS2KDwhZv1WPB?=
 =?Windows-1252?Q?EM8BRL3nbMO5PC5LTdzFjsZnpxeygBtEN5ARiZgO8FZJKxss+YBR3v1z?=
 =?Windows-1252?Q?BmT0YJ1Es7TFQkHqj1o/UFxsmZWuQj7DcvbvednxAbCZeTvelO12GpkU?=
 =?Windows-1252?Q?8L8b2NMBiSzxCo9PFnIoIDhaGZU7nVcInxVVygBAZR//cnYBoA2p+tOB?=
 =?Windows-1252?Q?AngpIMqvtgI7cUKUC2fFFhMkED4Uit00KV3OWO5xMUv9e5q0gl4h5XFb?=
 =?Windows-1252?Q?K7m2O/HVusGzbR/0gBYCOXR2PjgAFyo4q2GPFgnmjwZES+feuahoMhLO?=
 =?Windows-1252?Q?dPSbr/d6HIFJ+tg6AX66VmHMJktRJhxVbIG9IKNcCZoXQb7N7UpqbL7E?=
 =?Windows-1252?Q?UC6JxOvMjIorfHyyL6KmwuKYdf10P1HAXx3ubIhdw/jpOHNzqVtqrNiu?=
 =?Windows-1252?Q?BQcRLnW0E4HEJGrMj+OYcRlU5Xj2IvGXoyc0rCZgKqBgvdUCW+ENiG8y?=
 =?Windows-1252?Q?WBCnCs1E/1kcIeEkAwM1DvaCwF96yCbtZjmtQCNw91kCFxX6XEMfAljG?=
 =?Windows-1252?Q?jxCnIbf6M7p1fLW4yeSZRp2vWqZLSzZTvAo4lahJEY3qhne7mN6IBBJk?=
 =?Windows-1252?Q?g7TKoudSwY0dQ3f9470x9WJdaeSqashAnTWBxboRCBIj72AIlzQxmoQB?=
 =?Windows-1252?Q?TyAmMz9QrwpOquh3BTowLpkbx0Ki9mbFgXdrX+ncKu7rQ+VfWP25x+6o?=
 =?Windows-1252?Q?IcLi5uDBb+qgsM5+aBde53bSN0R2cPlnMK6HydGu5/ylT+55NUOhwXOQ?=
 =?Windows-1252?Q?8mJdduYEV9wiQpJV8PSO2E9l1ptv4JC7AGbT4a/XTPuKbGteF1oaCmNR?=
 =?Windows-1252?Q?W4L6UHkICzUXyRwvX02Y9LbZunzwG1M0CyZ/GgBJGzzsb7LXO6b3eWWY?=
 =?Windows-1252?Q?1FZkxScPLzJQ4xClAC7LPkeFjSwNRFmTw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3215;6:F1oOaFUowDXY3g80jmb8IySks+F+7LZsur1sw6krx3wgcvTN03hrbjEBjcoq6dcokEZGr4r79NbkqtDnKhlPD6Ou3fOtrzW0E4bd1MnXUT1UZMHP1h9GnxEYKzjroKBzNFictpRHj3LeCkOtGIsKhk+Xrg4X4FZoCZhl2qGuu39j4BYPV9wUF0E1PLibMSCcjNoPrHglRDbkSrbjqEgWTg3pfu15KASFnjDI5VOkDCtnNNxkoASstQkF+k5XyvHXux9W4xykeCXrlLpStNozNmtkXwRJ5Lw+6rgQ2kjuB4nDiPSdmMV/R33MkyoUTjogyfDWpOxTP+4rrgcgohH6fKeaCJcHBJtHy2AFeISkucO87vw8ugr5Q6+DSqSyhXo2olLDUBjDjqnow22011rb9LyIlrPPFnUlaCyNF4dyPs8zuSUjNmYhYaW2VrOc80M/A8uPg1pvD9LUPMCzzvIJWg==;5:f4TlhH2HVKUkX+YPiCIPA5t7dwWhkCqiXjJT9EehbGCStYxJ9agJsoVquey1z7STM+RoWlpacOAFQu+tEsChCLEC+QI3k6PimjNIdhHZT3OYIP6McQC0hE3dnt4aVYy47hIfOC6S1vQWdRoseyI8nw==;24:S5sZk3T66JuAHiysMqiJIjgPqaNcf/8TC7miorLu3bx14DDuXC+ysNNyR+zuYFPP+oWSVgcF3N4FidvJkBhs0tJBWqY8I7ZIho9punInc48=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3215;7:/WgfWW1rF6JqxYfKbPz3ZqQBi86Nf+2iH1mSGcZIUVv6sNu0Hf2uQHNkIup3BEk3n08kN/pB7PC1nW3IQ6C+ARzimbjkr8ITNrc58UJXOMOxEKNUkcKu7xLyWn9P0QPSIqe+cRqAjpjxdQe4mX7jVbdJEXwO0EooV6xsS1wtt2HlmsZ7yPMCxsMlCIiC1hxXxbCDNMFG/8HAzmKwvFoDh4a6biRDaKRQZ03WpxwBXWM27434x7v3rjF2LAwdk/ybizjksPgL+1AHHdP2KUPWttPeEh9/9+xeFQ+bl+HtZkE3KNtXcCMOfZFPo8OWmKyoQPsbBw+ibryjRdbZQ/tNrjqdw2sJa/frGtmVAgxObTgNuMv/2QitW3oTrVccmug/g/DTYfNK6IV1dHSoPiBUAdvpfu2pQ8XSyaplt0MZ3tIBA+rX7nHKIoDU3pQ7UcROuwvsH7Su0/N/kVQvU1NyeA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2016 12:15:31.7607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3215
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55868
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

On 11/22/2016 03:05 PM, Matt Redfearn wrote:
> 
> Please could you see if https://patchwork.linux-mips.org/patch/14554/ fixes this issue?
> 
Hey Matt.

Unfortunately when objcopy runs, I get a segfault and my image is
corrupted. I can send you the output when I add the 'V=1' flag if
you would like.

Steve
