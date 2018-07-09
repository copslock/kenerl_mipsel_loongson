Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 18:03:39 +0200 (CEST)
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:9362
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993227AbeGIQDcXNGwZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 18:03:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO8m4v6325wP9UNpoIpmlqcTXSDBa7r/RRjN6+eEAdc=;
 b=Yujq8/o4aC4XKEUavrLquJuFGhdtdT6tBO1b8udF/L9IrGkP5Ee51f6TrdIERc9zQK+wsOEuMOnkQNCY8+RaYS3SPVJ2SJFHaRd1x8tnuWdjejrAUMywN4hw5nNQIAqMPvW1I6JfSPkBza5d+K9tW8uYTzaZsVdLaAvQ8U2Y/LA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4938.namprd08.prod.outlook.com (2603:10b6:5:4b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Mon, 9 Jul 2018 16:03:21 +0000
Date:   Mon, 9 Jul 2018 09:03:18 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH 2/3] MIPS: Use async IPIs for
 arch_trigger_cpumask_backtrace()
Message-ID: <20180709160318.vzxozsx5qab436xc@pburton-laptop>
References: <20180622175547.17716-1-paul.burton@mips.com>
 <20180622175547.17716-3-paul.burton@mips.com>
 <tencent_68D9A09D7C1A9D9D6452E6FC@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_68D9A09D7C1A9D9D6452E6FC@qq.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2201CA0073.namprd22.prod.outlook.com
 (2603:10b6:301:5e::26) To DM6PR08MB4938.namprd08.prod.outlook.com
 (2603:10b6:5:4b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b3c01df-32bc-48de-d35c-08d5e5b57e8f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4938;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;3:Fcbi+zjTMtG8rxlyhR1E8cAI7EwBukB1Nc51oPMWgUL7iSwoSFcvJLCHmbMq4g/KU11LHB6yMObhcWcirRjr6tGXP9SudtLTM78EciyywD7ALdMzlwvEsTzYQUSjuNnk5F/gv+fBRNOMGIk+xX+6B4dqn0pcY4i4cI5IvFFLl5V0sfjXPcUREXrxI95mtZ5sLXhs/bYJaCQVzmbaoYg6j/Xmbpuf0zOKMr6WKxN0kv/nuHFWBj/m+99LCSKmqHfr;25:JZp34c8uhrMFYqyRbKIlDJlIBWmOtYrR8F8jz+sU4WI2xuQuKRDn9n+YIY5rLD9rMqriQ4TyUCIsukMigmdEFBhlCsDA2rjOgOdw5c+SKtQ8oqIbZ+TO+bRaOj8PXyFTkM/N3Ua/qpXtOF1X0vnIxSgVH85e/ZlnTli9QJ6X8Oua01rnPLPSwmriCtneQCfiGGnDNgRGXQutm1g4XtVzW356mhvSPgJrQsau2YYqSxfEQgh66WIL3axiFOlPKsSVeLaGG8BcGv1pl0z1YasJdsNOSM/IYnUZXLnq8sb/BzvPFLW+VPuUgWy7ub9cbfqMakaSs4COD9EGYXg1BKKabw==;31:imhsdctYCxOFVxUMG1x6hbMMLFsy3iXKIeSnWkk2mNVnR5ybgl7u5dPMCrpPc2A8ihk2fU10KKkOy3xB1IZBJZWU/eNgzdJ4V7VjwSIIHqG3eut+eW6rBUr4xSYL0GvneK8OdY+siM7vGFq6YtVpZ73Ih80U8PnfzxtZ3lZiNtcOtCTJQrBLr3wNKxjz77fkb6VSV5mnxhzjsYVdasBoVVuBGYBQGxKo9TD5IjN7jcc=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4938:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;20:y7EVNUZnnp+tsp3OhPlTP6mWOQuvXuGPbwVeYYmIrwLOSAVpdCgkHX/DNbidPAzR1d/zhpBsMhPW6be3NSn8bJz11NZjfNSugIFKHTmySMwVDceDTdxdKX6nPKbzD2iG4pHCMYw9fowixQwAScUG2TxogkcRuTXEH6PKZOuxS53MA0cKsvUaqBWLR7i5vg59j4l0hIlvrkseUX2LfQPid9nUhX6A5nyIZyXpzOnot0O8gVjKVeQXou+FkVWQ60p9;4:cLI0cay97nWuR1XWnQrc0KXLrh/Lcuiemo+UBa240kCHSmh7U7/pXowC3FhcPasft4R5zsRFLYH8E0xKEGiXoOeaxdjpdmGkg/4KIpN6jRtNgQktibRlDp3SlLDQOJmd7KjKLajhwGLsTlQEdy/oRHldAIwvLHLSPOzyJ2UJjoMUjULCdboBMBtVun0gZBy3cjDJ2NmScMxH9uMlPR4ehQnJL3X8dWDaWtrnhQUuGvp2ec9xi9yyNzAn4RLf23mZN7P2O2vYyio828qo1AYiHw==
X-Microsoft-Antispam-PRVS: <DM6PR08MB49385FEF9F4DFB9F1A55D3F5C1440@DM6PR08MB4938.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:DM6PR08MB4938;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4938;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(396003)(376002)(346002)(39840400004)(136003)(189003)(199004)(50466002)(33716001)(66066001)(5660300001)(47776003)(53936002)(6666003)(97736004)(229853002)(6246003)(9686003)(6486002)(4326008)(478600001)(1076002)(3846002)(7736002)(186003)(6116002)(105586002)(106356001)(76506005)(25786009)(2870700001)(26005)(58126008)(54906003)(386003)(110136005)(16526019)(44832011)(446003)(11346002)(956004)(486006)(42882007)(68736007)(476003)(2906002)(23676004)(2486003)(316002)(52146003)(8936002)(52116002)(305945005)(33896004)(76176011)(8676002)(81156014)(6496006)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4938;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA4TUI0OTM4OzIzOkVhTktMM1NuMFh0Q0tWVG5JaTRyRW1NZTZr?=
 =?utf-8?B?d2RzMU1xa3h0cTBtV3ZkamF1cmhUWm9NNEVEaWpGQlZSOGJ6T1l0NzIrNTlU?=
 =?utf-8?B?Y0ZTak85ZkUxVm5FTmtBb1VsQi9vZExKQ3RCL1JBSU9iK3R5VGs2THdBNTZw?=
 =?utf-8?B?cW54cXFqYXVXMlE3Ylp0am56eGRHODFZaWF5Yjc3YW1aOXNlOGVwMXhRUFlN?=
 =?utf-8?B?UjhqY1ZncGM3d3ZHT1EwK2ppQmpKWHUyV1luOGNzWEJPT2p6aWFRbWI5dlFz?=
 =?utf-8?B?bFVXK09XR1ZYRG9IeXhPemk4dlBFY3MxaUJ0N3ZtckhzZmJBSEg2SWVHZGNt?=
 =?utf-8?B?WklYaENqRmxnclQwUENnMk1veGtrMC9GeTJIYU1Yam1Db1I2VHlEU0d3NS8v?=
 =?utf-8?B?YzNrWHRxUlI4TkNUTzkxNVBtNGlxeWJmUkF3VlMybnY3MXA1QWZuQkQvSmoy?=
 =?utf-8?B?cXhkTkRMc0JPMkM2MzVJYUFMVFJTZVplVlJrMFBsS3RHTGFkRHRtSm9RSkYx?=
 =?utf-8?B?MmcwV2Iyb0Y3d2tMVm40UzhFbnM5ak9UKzhHOHA4blN2VThwdXR6ODdRSUhi?=
 =?utf-8?B?T0JEUWNMeGs0SWYvRFJ1dVczTjNQMXU4MGl2SG9wUitLTG5hdFd3aWs1Q0lo?=
 =?utf-8?B?SHNLRWY4cE5mMEcrNndHWnBGY0dDN0tRNDlaaml4alRVZjBrckZaMGVrZWw3?=
 =?utf-8?B?a0wvL2lJM3dpWGw1c1R3UDQxaUtDMVNwd0RuN1hiaDIzSmtSVVgrR0pPWkdx?=
 =?utf-8?B?aSt3VURRdTh4dlZpN0JoeERzZ0ZhL0FaNHI2RUdhZFdnTERERit4V3IvbWdM?=
 =?utf-8?B?ZHY4aUxvM2RtUDR6QytDbTVmR0FnNlBQTWdEWGVCTVFDTUZ1MXdjencxZC93?=
 =?utf-8?B?RDNiVTlVUmI4VnRsQXd4ZVFpWjNqMGhvbkkwWnJvcEYrbWJBRjByblA3cnVH?=
 =?utf-8?B?anNoNnFrOHNwVGZ4YnJ1NUZZQnpya3R2eFpiTytHQi9rcWZlc01sQ1BqaExW?=
 =?utf-8?B?ZmFoYjBrZGFnRmV0TFR5aWdLSUdvQkJjbS9WcDdoaU1DQTNBaFZRTVdpazlD?=
 =?utf-8?B?eTJuVVZDbGxtN1RlSjluaVE2Wk5NMStRYUtxMVFHbFZJZmJNR0dQSk9YRkVa?=
 =?utf-8?B?NlJkQUVtcHR0NmJXc05WUU9XL3BETVJOaGJEamVvSmJXWk93c3daREIxTGdD?=
 =?utf-8?B?N1dsenY2VDFHMEZUZ2l6em5FOFd4OEdqVnVlN0hCT2xvZDFCNHZrR0h1UHhF?=
 =?utf-8?B?MXlJa0djeXU4alJDZ0lVV3JpMlhuVzNlWDI1VHhpbVJHb3hCUTJUNU1rL0tV?=
 =?utf-8?B?MkpnZGNJZ0dsZEE0bm5EQktxRHhMUjdObXZXTjJsSkttcHhuczVxR09zemxK?=
 =?utf-8?B?YkxTK25CSFd3azRXTE9qcC9DNmxIamJYZGNMbFNHZmFDY3Y2OFpycHE5cjAr?=
 =?utf-8?B?WFZwNGUrancrVEtiNGtYN0dMYTJxS2d6TEdreFNDMGoxOGZUWTlCM1JmTDgz?=
 =?utf-8?B?UllJTFIvOU1xME5pM21aYlduM3I2TThZZmNJRjhRUVdvMC9ERm5jaW5wc284?=
 =?utf-8?B?VFFrOGpZcEVnUTgzTDJTaUtZbk9EQUUvWWNRVEwwNHhOUWFxVVczOExXRmZN?=
 =?utf-8?B?ZUN6b1FvQjRDZ2hXeWVOcXpaS1doOEJXbDVodUpGODM4WC81TWs3ZHNTZndI?=
 =?utf-8?B?eW9SMzlHUkZLaHU0R3BWT0ZCK05JSHNBYk15OHRDSm4vSW9pS1RPVEN4TTZ5?=
 =?utf-8?B?bTFFR1RpeEI0K0dWN1pkTlpxdm5mV2VYSDQ4UDYySXlqN2Fpd1lSU1AzMjR6?=
 =?utf-8?B?MXRqbGJhYXdxNzZzOWl4VDFoT3BEdXMzVWliZ3FyR2RWWFE9PQ==?=
X-Microsoft-Antispam-Message-Info: Koe9XCjPQkiCpl4VbGuJx117KwUdT/Cpe6FqHoKVy4gXfQJWk8UnWqnFb1t1WpgsG4gnEV+pINFxYlO9Y6ro9JGGNjdGZXoXbULIaBU9nNBXnk6abXSKaMisJ/f1dSu3EJ1DRnATF2aQrglSaLKr0HD8uT10ILQOygvOCKKRG/4vPn49SamMkbU+usA+R6LgUUp7CN9ekE0CQadB/tbEZFBC5e7eZAcuSSgEBJtY1dbbG41ak+XFhy9HqsRFJ5Fjss9HuxFk/YWLC91peU5uzrE5IBUcL+f/d4F0JnwzFgkIb0FFjXprgTNjEKrmgXsWzTehN9BZ9wnVXkPiUjvQRxekHeSuec7s1g9rIRKZRSc=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;6:2y+vAz9cbz9Y6z38U9N7phVMrgQ+I+iYLi7wcb7TR5apZ5lMlnbSu8i0zKulY5fa7oOIZevQ4W7E7XtW+djnUHJqarcr4ROBZdzECG2ZmohLSFwOMWXNnh4C4WsDjglr7SzrGsjWUfR0z/ZueWl/ZobUDzSIcbheI/tJ2NfeucCilkgKOmCEX0BXWBxRZiGkY1QkJLnBArlYPz3TtNRxJ55uFrs281CFAzKnyJyatEDtObzVXlonGrPSDgTaP4kFWvSS8ABaToQKbaqx071lBU6NuE2Gr49odeTE+vRmOp7mZuJZ4mwVoIIZdCRoFH0CYEzTNn6vedTVgnGNLGZPsFdMiwuvGUexCPM+QAucKXaqy6cz/IZ7uHR8ycSJbgn94dbpvt140K81aHYTaCss2CTrS+4RZow1igIihlgJR7UjrPaa58YLChKROdwiBVBdH1eTWNirXrkdeZ5a8hAjrA==;5:9J7UJ+sG1RDuusPvTfOy0oC5V/iubr2SWwxQaJKiL7eTdflVaMKY4pwlqaP69aoK8HwJniOOQoqe3Q0YlOPWiwzYsfneOqqacebUcfmiB1uIVjzZyS+BeS/Euv631LzSUI8ZCoSXrOUG3Zd/eXSdu13BLOGIVSGxyvcb3BMqhVs=;24:vjMcXeb6kuAWVmuVUfk0U7yfq1yV1Fml9aPi+RDwke746sJ726e5YrZsSWg7DMpNGDafySeg+yLtII5Fvy8zIVqwVG+WbpzSok86B6gifSo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;7:MbeqMIvWhA3uM9OWniJJpJldpGG8ue68Oeg+sLaRJblE/ZcoawoArjETXif8EI39rTBdsbf8T+Pjfvn2pxdwovlbNbaSA4T1Dfeo8LaLrFPkx6AW9L1sbqRWNna5JLPTfqnFQ46sEQWodTBPqJAiYb2HF4BX0h/iVg+qUlUO8TacuO2gqRqpMJ8Z9FqjlRtQ5sbJ5shF0AEX3x5JRNZDFxP3jz+rub0RZ19fq41TqygRNDyorrSDxobBHqDVBT8F
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 16:03:21.6270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3c01df-32bc-48de-d35c-08d5e5b57e8f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4938
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64715
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

Hi Huacai,

On Mon, Jul 09, 2018 at 11:04:32AM +0800, 陈华才 wrote:
> Should we do something to avoid parallel backtrace output?

nmi_cpu_backtrace() already takes care of that using a spinlock.

> BTW, could you please check the linux-mips configuration to not reject
> emails from lemote.com?

I'm afraid I have no control over that. Ralf, do you have any idea
what's happening there?

Thanks,
    Paul
