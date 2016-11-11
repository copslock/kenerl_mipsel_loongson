Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2016 21:51:26 +0100 (CET)
Received: from mail-dm3nam03on0079.outbound.protection.outlook.com ([104.47.41.79]:1694
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991940AbcKKUvU2GfRc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2016 21:51:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0LtvAxqlv/CZBEZJ6/1YwxmyIp/Tik+63dIPm93eY90=;
 b=mJhazzkgOegOmMoJOsc5EQH3RiYn7Scw+lP2CB1J+2nZMExgArV8PJZbcX2IlGz8rDfRVkAE/HLakTkr1TK60w7k+chInKO1z/h+RvSK/CId8Xx0uQvdTZ9s8IdJADpzRspnzEyklh2ltPJR3BhyLB5OtYrI9McvSZgoa1Kpp5Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.707.6; Fri, 11 Nov 2016 20:51:11 +0000
Subject: Re: [PATCH 2/2] i2c: octeon: Fix waiting for operation completion
To:     Jan Glauber <jan.glauber@caviumnetworks.com>,
        Paul Burton <paul.burton@imgtec.com>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161107200921.30284-2-paul.burton@imgtec.com>
 <20161109134103.GC2960@hardcore> <1595446.2T31j1Ekg5@np-p-burton>
 <20161111085707.GC16907@hardcore>
CC:     <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Peter Swain <pswain@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <2702c562-ca4a-b7e0-4828-85f0df7d8f9b@cavium.com>
Date:   Fri, 11 Nov 2016 14:51:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161111085707.GC16907@hardcore>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: CO1PR15CA0029.namprd15.prod.outlook.com (10.166.26.167) To
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148)
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;2:spy/RBLoDiZz2b//4lyIeFGhGvB3hyk862nCpzryHMbuu0y0IghwaZ3GgYIXuzI7F72KWfgxQ2j44Yztfbhai6zWqsZT/Yr2nkQs+bBpkgg4MyJkQ82gfJ9NpgUhYIgWW6YE6YP2LbKvQG4hwzBi/EBzKfN8riygXT75ifSjqRA=;3:jyb3/rh0t6wRFxlFYF1vmm3tuDSy+XH6yr7DtFBxTlyIn8S3sV6WXOus+3hUGY4GoIXsXoSJnth0VbBjmfeY0dFb10fx+I1xcVlgACkCqJIvpgkaFNPnBDUdtYL87mZSD5WCkJPUfI/K7MO5E2CqdgNn9KD50jc+p/4kkH8nDwQ=
X-MS-Office365-Filtering-Correlation-Id: 93d39e4e-0788-4288-808f-08d40a7478de
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;25:4iDFX7Q/vE7+kWIDPx+SPG84Y9RRgHX271ExqVmv0Tv6Ye7jgO3ombBjsjKtuetToDgyP2Hv3KoB6djzPjnx3SRHrnwDTTWg63Vt7Vii5VkpzgkaX/K6UoJg08A5JaabzFuQKRffRr4xpZBb7E7H9AaUK5R9Wp8jScx0EMfCOdvwcVZJQgri9gvw0HI9xs1TziZk4kwakwIyrwZ3eTGMDGmpKnwU/SLNwrLRZhpvESBRXORW+SrdeIlckOoU0XwH0CGyEodW6l/CPfy9Viwp7uKtd/AsnF6yrux5bage33Vs7qC2hgOY9AFL1xwIDN4ZBHKhCB4E6AUGpRTVx4mxV6uC2pVwXcapUlN2MG83y4MvOqopqddImrlSP7sWegx26UKYGwK9HRoKD3t5pJxA0m0qv2zLWoD8fp5NOG+jgy7tgt4907aWfitcvUK1cXFnmqp0p4q+Ju1+FzMsU45NH4lhUoFajYDWyd0MA4VjMcLCK+XqfJ/Yoo5+63UwpFmAGpMcq0x4rsS/6FM0KvBle4KZ+c/lLLCaUIZeg1z6zKwkhkfLthDSmrbkb4N0FiYw3hnzW/v37l9/RNobMNWAFIWfLlVImNqjbwmzqvE6RVlRCV6wSy5O0ejws6ENiTAwqni2LAlsvtu8m4MI4RXlDaqlzs+1hd6wclLdIFqx/jqUSlOg6HsAQGGi1av12Yc6R7csJPnfItqn0Uv6LbMKRfna2Rt3SH2G1KkkkqohHLu/l2ZJh8YLvVeFrZnFQyfbgOZdOXy376b596CIRBgFHQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;31:Mfl4XGwFRYmKIFaPQ2DslZGVwhvCMVGb0+8FQxrBGxLOrtrYLMA58p/1ANRDiQXlXgoPgDbL3nWPtBc6mqkKogTkDGTwU3+HYxvczlKFy8m39k0WSUQRlr+OWNYgiX/+w8McrlsAZmtwVwYRbC7RZR4IKbeiiVH5kmf0hFPwWVzdT6+r9DcXeTmhnpooX+S38wGfSdj8x7HfLqZcknsvxsP3BbfSk82kyUj/3BbXV7iV+KfcX07OlSRKKzP/QnTLL/xOVRyBy10pO4bf0VTsNg==;20:EMUaIzKy68V7MLuTfuvKyHNCCWll6wzPGHio764idh4oWEM8YjQHPG3PS/BU8DUYwPx244aMWmPEqZVWs6YdI6F4wiVHlrte4ijrAyUmnPhQBInvFQX8tTO2Q8IO0TMmVI2VklM/p8J8pZgflY0w9tGRGd76MHbXDlxf9bdyazaTIKJhNb1LbN4Bbk3m9Fn2Pu+R7jbouUYBO/aKcBeNPFef6OgroK3zq+vnIOMryJu3dE3v7XFK1F+E4arNDsmI1FUgI+6OmVWymq7S8Al3pi7kd0Dk2AHWk97v79RfRpjpkT5VzEc+Q7ECh7B4KHu4SrlPFn593rkCjCUd+PeRb6/KLIV1Y/6iovu3QJ8tzr8cJlY+5CnKq2MEI7DlME0g+MhSk7qmpGU3XatQ0KxnUaWiGA+//kRWKrmxQn9SnEf15+XvTkkkRFRBIGsomnW3H+s9npfnGD1D04kNQT7IdQytYMKpWrwjrwyHyeJIwYqfF4XNYrcqatI+ggSb/lV9
X-Microsoft-Antispam-PRVS: <CY4PR07MB3206766DBFC612A1740CE46780BB0@CY4PR07MB3206.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:CY4PR07MB3206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;4:NetX+GeVPkB9czd7EjRxgi9BlvTENin8Y8q3UWx/jE/okwgqVPlpI/JSwdFs84EzH1fech7bz8t1/sliDuVTYgiR6sV7cMm4kVgg0yOuxGfUvsok3atReNb9MrOB1SsI3QpS0C4LEULG/U+bTi0+T/G3Ue9aP/0o7xNEbIfxjxXG4NYyVKVhL54j2l+mZTKVi0nqaz6vsjBDLV6Z9cB7gJ+2FyUejcog5ztt1xjS7NOj28L408ze5qN9wT1czi0mYqpWbmJKv2IUgzJViE5KIjeC5b/SY/SMXYwnyBxQ0NbLhafivBbn7GMAV+XMDKWzeY0IDyk0b8uiE4Uk+cqg3xOOEzMFF3awmFoKzpRaQIKWj9MiPmNkIuKB+8x6mh2ZQT2NzJCL5pZg4qVZGJPFCQ==
X-Forefront-PRVS: 012349AD1C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(199003)(189002)(377454003)(24454002)(5660300001)(77096005)(97736004)(5001770100001)(33646002)(189998001)(65826007)(23746002)(83506001)(229853002)(2950100002)(586003)(3846002)(68736007)(6666003)(6116002)(2906002)(101416001)(105586002)(64126003)(81156014)(50466002)(42186005)(4326007)(86362001)(31686004)(92566002)(81166006)(106356001)(8676002)(93886004)(4001350100001)(36756003)(230700001)(76176999)(54356999)(31696002)(7736002)(50986999)(7846002)(66066001)(65956001)(65806001)(5890100001)(305945005)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3206;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY4PR07MB3206;23:Wi4zTHHz1oM1I0nhDNpd1E2woEPSbMU6XXayN?=
 =?Windows-1252?Q?569v20HRps/ZHrQjvHaJhJ/bWh04Mn2SCiTdJZciQTYvun0mDkhbJmiN?=
 =?Windows-1252?Q?bsgnfIxV0zWlEIe/KcZUL/kUDaGqZ4o1OZfLkfwMsfEPd4NIosTu+WoA?=
 =?Windows-1252?Q?HnUrUIHGfjtijn5aAJ60oJG2WeN0j7x/1hxU07VabCKOGX9GHDmaH5I+?=
 =?Windows-1252?Q?UyS36zBKaz1TCUWFausfTHsvtQDGnfz/gVqGFz5mbUEh9UWn8DfptUzG?=
 =?Windows-1252?Q?oQ8V50Qeq8PVVZdKPlKv+lHhXDi/2RxLHmjOJlHiOBG1PRYkzdFe82je?=
 =?Windows-1252?Q?ztAvUDPduLW1NFS3Jg4sVVCpxTOh64S6Rl4b811d5tqHGMin6cR31d9j?=
 =?Windows-1252?Q?LB1u6cJabPx3++UyjTG/0F8yz+gI4ORx9BVLzwnAYNWglj/EED4qGxyA?=
 =?Windows-1252?Q?q/fHRTqIWvcQS0nwrrUPtCfMfU8XQz9gSH7iQKdlLBVek6RIz2+rQLy0?=
 =?Windows-1252?Q?LCWP+ziYufvCEFEcO9VLfwzey97a8J7rYsy1mGKMJYgR0Or5Wm7Ty/ux?=
 =?Windows-1252?Q?BFw6FbcLUsAxP12eDQCKuaazJBWMHaL1EmckBAv7wzsg9YRjE9oKMsRh?=
 =?Windows-1252?Q?wLf8vSbgtHMJT0Iowj2x52j+k4q8H7Tki+vNrG9zwrjySkM8h5jakJJi?=
 =?Windows-1252?Q?r1eYQJo9q9V7WdpCqydpyDhSvVyWnhloqGm1I1qPNKlGzl6vnNsWznKT?=
 =?Windows-1252?Q?VXgbNjdoUWoMZDDag9wsbpgX4JpVT50fiOwgoPDoFKT8hYd47f19jz1z?=
 =?Windows-1252?Q?z2SQPD2eqVZUqn5ILF4CTIDn/7pbl1P3fVr3iiMdeifSKV9DsLeMMFzD?=
 =?Windows-1252?Q?mXeVcbe5kK0PhDnfJfJlxHZ8vksfvBH3l4INWRz7v4vF42nTqoUAqjYp?=
 =?Windows-1252?Q?RFCD4btvn9S+ws2imm9lG7BPW5PBZrYIfx1j0EkmxvsHiTbjFNKOgCfk?=
 =?Windows-1252?Q?/tg3/zPKipFbRaKSxKK+7WrHfx2NPyN77TEKQxBL79d0sEJaWkvZ8ynN?=
 =?Windows-1252?Q?bqGC+zDddn6F369/PT3q0bPHxqpldt+pQUzX+3q5j65fhAtbj4mY3lG7?=
 =?Windows-1252?Q?7YxKpoS+7/QfAWP9dDvvrDOai36NgKoLtduROjixqqptTYz9GcuAfw1/?=
 =?Windows-1252?Q?LDTiEL5DAAa+lLgZHEZdF1HivP3rUes2+URetON6hFSM/vj4LF8DAm2h?=
 =?Windows-1252?Q?pscFubBWm/nrOAZ7mPZMatEB2hBBiCgWgMj7wSLwbiASo4AH2WKZO8JT?=
 =?Windows-1252?Q?HNN1VCuEPVpZ4EFapQUoKx/3WZfFrDFC3n9oGkUaUdx0hypjDV0PyI51?=
 =?Windows-1252?Q?u+J58neaUCRZ/d2M2Q4eandKt7jq2W4QVvbkD8c+EEsL9nf3sBeRRW4q?=
 =?Windows-1252?Q?LV3l3eJXvBPsQ1vuR81?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;6:LZsbrXZaPhqcEfHuwUw/TrW5xgAjtrfIAPrgFttn9gIxLbenjs5ezBmYk/V2QcYg45cDnpsaGYcy+Wew52Dwrr8h8aALQlRZqlgJexiOtrcw1Ao7WamflQlHgWuQ2loNNc5wKTQ2GTW07n2xHx+BVaZCmJSPoY8I074CMCOgcms9m4+G0OwST5LDHqhuvx3ZldEt3O3SwyJbrs+IaOQ4bcFZ6RJ124NbXssENExtorlnQg0I3XOtx6JlLJcWtncUcqIr1SOJQJ55aWFgiSkkqn6povlJQX+g6UDS8K4WnGzMowdJLehzURzUOSN5jB4RRIWWjMF8YgLP1on9ykI89qGRnYJ2grrjNOmUErOabjQ=;5:3B8YF7VJetsNDnNOP3hh2DkMBzytpDX0/X8t0DGuW8CJR1XuPlgKKHlFmXkOPOy9DbUtogUVDDNatPuhP8TA5oQXrJm+JbuGj947Dztv7jBdHsPTnHyRtLWD5HcqNDfvN3i/86Ce8kkTrAI3BMowJw==;24:1N5eQjePyWEICYMpfcrGAiCgqX7I7yQFheMDZWvPbdPWaIDxuvFfo/IMAYdNWJCAOCn46j9dJm/BDDCtrwroHfR2x0/V1EUAUe4F2pRjUXU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;7:6o16Hans8B6pHB0Wx2jYP7eI++x0/fHCXh3ltVTOoQZBIbx0qSpb0HGc6NaL1xeBHdwdff8DXChgMst5sCCSQjSK2xyxZRZs97A7gaXNAL5jpC5JNucRa/bCpZJB3PveNxM3NAggGaxzlf+KujK+sWGNC54Sx1Xlue+YGrpPSzrXtpntxwA8PVbfibMtCOt5RSEydSQcGrZv0q9BP89lnH1L9tkD+62mXG5wxsoM9P0NiKBy6tmQrJK8Vcm7MyaTsx7xwvXPGlnoAzVGtwoaSV2ydkJqRBs1p8k34IDgJ0+1VJ99MClpDi0C8MNueq9JyHCcPFGzvnIXdZXSeujQvT3A+6sAJOCL+TLmT0opXJM=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2016 20:51:11.7286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3206
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55787
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

On 11/11/2016 02:57 AM, Jan Glauber wrote:
> 
> we can reproduce the problem on our side, but I don't have direct access
> to a MIPS system so I'm still just guessing what happens. If you want
> you can try the attached patches.
> 
> I'm trying to get rid of the polling around the interrupt altogether.
> It works fine on Thunderx, sometimes I run into an interrupt timeout 
> after a lost-arbitration but recovery/retry is able to clean that up.
> 
> Please also revert 70121f7 as before. The last patch adds some debugging
> output to see if we run into timeouts or recovery.
> 
Using your three patches without reverting 70121f7 fails on both 71xx
and 78xx boards. Paul's "[PATCH 1/2] i2c: octeon: Fix register access"
eliminates the i2c probe hang and both boards boot properly. Tested
on top of Linus' v4.9-rc4 tag.

Steve
