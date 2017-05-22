Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 15:23:05 +0200 (CEST)
Received: from mail-eopbgr00132.outbound.protection.outlook.com ([40.107.0.132]:29504
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993552AbdEVNW6odd5N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 May 2017 15:22:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ev2hW0kObgA2jbyp12QE2/ECPVih6FKqzYiy3X++5Kw=;
 b=Tdj0BiTwYPeWOHsfStKyPNI0gDLJ2oQ8KZeDJ6Crl2uP58FisHjLjwiLIxGfzQ7rHBcQLoAx0bo43j+ddhkx7qj6HXzocVldTYnMVbpdZ7UIzPPQTQhjdC8VQUEu7TMrAXG1y1Hvdh3apaqMBALrqZbDo7i9BXhsEl1/vpVXirM=
Received: from AM5PR0701CA0059.eurprd07.prod.outlook.com (2603:10a6:203:2::21)
 by AM2PR07MB0578.eurprd07.prod.outlook.com (2a01:111:e400:840a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1124.5; Mon, 22
 May 2017 13:22:53 +0000
Received: from VE1EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by AM5PR0701CA0059.outlook.office365.com
 (2603:10a6:203:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1124.5 via
 Frontend Transport; Mon, 22 May 2017 13:22:52 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.241) by
 VE1EUR03FT064.mail.protection.outlook.com (10.152.19.210) with Microsoft SMTP
 Server id 15.1.1075.5 via Frontend Transport; Mon, 22 May 2017 13:22:52 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id v4MDKmGl026914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2017 16:20:48 +0300
Received: from [10.151.81.97] ([10.151.81.97])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id v4MDKiZ1026845;
        Mon, 22 May 2017 16:20:46 +0300
X-HPESVCS-Source-Ip: 10.151.81.97
Subject: Re: [PATCH 00/21] MIPS memblock: Remove bootmem code and switch to
 NO_BOOTMEM
To:     Serge Semin <fancer.lancer@gmail.com>,
        Joshua Kinard <kumba@gentoo.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <ralf@linux-mips.org>, <paul.burton@imgtec.com>, <rabinv@axis.com>,
        <matt.redfearn@imgtec.com>, <james.hogan@imgtec.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <Sergey.Semin@t-platforms.ru>, <linux-mips@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <be0b6614-708d-a32a-029d-7e606a673e5b@imgtec.com>
 <20170522102643.GA17763@mobilestation>
 <ef3d7a8c-2a73-2082-0d64-bdb4f95df204@gentoo.org>
 <20170522130348.GA20910@mobilestation>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <f14c7a41-ae2d-b19d-fb86-d6e9c9c53949@nokia.com>
Date:   Mon, 22 May 2017 15:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <20170522130348.GA20910@mobilestation>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(39850400002)(39400400002)(39410400002)(39450400003)(39840400002)(39860400002)(2980300002)(438002)(199003)(24454002)(189002)(377424004)(9170700003)(4326008)(39060400002)(229853002)(478600001)(31696002)(2906002)(81166006)(86362001)(23676002)(5660300001)(64126003)(50466002)(65826007)(54906002)(77096006)(53936002)(83506001)(356003)(7416002)(305945005)(8936002)(6246003)(36756003)(22756006)(2950100002)(8676002)(230700001)(38730400002)(50986999)(54356999)(76176999)(65956001)(65806001)(47776003)(189998001)(33646002)(31686004)(106466001)(4001350100001)(93886004)(53546009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM2PR07MB0578;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;MLV:ovrnspm;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT064;1:djIq4jR7zQ4TEzoPHJbqi7pChqrmB4rGTE+3oYAUkoDQ2O7oNGKMHt2bSFQ8EbhkVsC7z3qP9K31BJjMF2bznvSpdPWC8vzl5B4YNoJLtUlaQWVBjlj46QXNCVSbIAVh2y1/UwxBvXryQYzFtbbCaC6tCHUbvh4RrH7Ok19K9K8eqBe3JZ7QSOC7Ho+YuUMqxr0e8NODsIZ2m/g1WtiXRo5hHTL7TeObEliqbXeu7EzRjr8KS/bEWGrepCTNXBdiUBnpK0a1uzRzj39c6DgKLfi84G3+XQ4Wl1R2rjucW5qui7rBMdGxvvsFN9uWqAKq3hhF/Wecv+fLlQ9V0GJ1mfAFCrmEayHnG4JNxCGetRXsynujvlGMy8P4KnSPycf12RXoqxRzhYBzo2Ki24VicaPTT6OOWwV8dC7oLWjbkK6niiuEwSrmxkyNll8Ykb9MFbybQPAFVrWnG5t/Bft89RToWrDaN2CbNY06lADSb4mFmvoVHbP6AOWrlRo00mMGYsFE59/FctIk024AoZ5ad1/Zme8Fl/1tugxTh60stv0QbOE5nP277noIau1Oqo2+
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PR07MB0578:
X-MS-Office365-Filtering-Correlation-Id: c98e9edc-c052-4515-858f-08d4a115a67a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(8251501002)(2017030254075)(201703131423075)(201703031133081);SRVR:AM2PR07MB0578;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR07MB0578;3:OsJO1lT7jITtlhIim0pqrofALu0k8+Btz1Skv+ehLQQmEvFnFvNdC1ph9aaE3LuGEsukW+8ct98NiBo3cA43QOEjRZ1B9SMjChL3K/WLAaoiN9QapsMB9tDNsyLDLyjIShdY+tKBHX9V+whw9Q/vUneSxz1pOwayQEjwzfYy10e07r7gEVgVdV/KxY/3lcELPc0yzQQlLs+hDhKtb34Ytzcf+tTeES/LZu3B9ecSod4vmPYG4K8FE6UnPi6bS4DwcIcoVS4+xEWU/30e+lAnjJyI+tSU5VtGR7+6KvEuGnyj5jQ7zny/P++4dnPXC1MDL5P40hCfNA+OVsOCrzKwT8l/JW+NaISuWnk5ifUZLTB8+HHojCV/erbEIF1pQhENsJ4hyf/GRJPoivUS4Rqvhw7Xz6dnFItGI79BDbuYEE1UhZ8gQNNVmULbdEmt4V9XosX03QGskOkX4rCMDpQuoptLGGn3Oob/pQkFEVY4mTuU8HBfeLs1eVmpGKVCsOFr
X-Microsoft-Exchange-Diagnostics: 1;AM2PR07MB0578;25:aKLwr/4cqkytG8Rct2Z0PFrNreRP9NfUlQn8HJytc5pKHbf47oiIyxmrqfYDLHPYcINSL8Q0pRj0WB1JDVeSXoGVxe1EPXtPYLfmkg1eX4Qa4LwdWbMgZ5UuUqSLykOqz/jd0F8CG/Pah2C+SfL8nvhFGeZvNuHK8by0qFVnq3MOXpVSQTT/P+/S3/KnqLStXGvZZjzFOn3n3gQRASXbNjEZWyZwm4t0DWxnryOv2+h7nZoBl1Gk1HN/KEAxg3ufC8lBVGvwrw0MhUeSA58lBIgY1OAB3UZPLDfNx+a/4mQmO8uZ4bfVp7vfnEJizl1fVrESjgGih7n4XtGK39b4+0kydRIwZPRMCHmF+ouKcwT7OBsnDG7O0PCDgOUcl4Y1DBhCesRZwzBF+dKvx+IrceP+IveNgaYTfEpmrGb7cHaTLRSqmgIsoKnwb6zNRjnTBggIcgCMPrm/2nLReTjtmWnCJRmZfN3U3y/l+rrXiyI=;31:lNub2BeSj5vmx2XdxQ/aQTH8ROT1+siRp+T4TxWRFIr8mI8KzCdv1DwlUfigXKFwzaAqUovdi20YfoIhJn/LwwD3mPHqQLKGLWURNUnWJfpjMWagEsdSZxtGy3ZgCuZE0nV3HFa1QnmVmEvBuWc9tAyh/vdk1hU4tqNgRGw/rvXzis5vQtLMgbOFegYvGNObPjdkmAVtOrDa611rmwKpmIzgAGCg+kHZpYmam+72rlbm4WtGVp7SrUZiDagC4voav3oIBP8suxfJSfARlLXUjA==
X-Microsoft-Exchange-Diagnostics: 1;AM2PR07MB0578;20:03t1OSAbYYfxWbeyxu8jA62pIAJlHGKtDUFGQx5jRlSPczV4s0awS/d5Ze4Qz91PnfdHXx94YhXR5JMYv9Qr50/ruPtXzMpu4p7v99KJtqhbCJYWR6cYtr/djUImGpp/a/ewnX8lkD+H8f7pQVytHqWPDP7d8aE3kCje8D8auNdKRdv63/K5cuFuSYwCFcMnKSOJ9brdaZJLTufDnCB8n6wtQTC6YuofjdNH3+p8M8bAQGQIPsXljpw4wmbA7HUJdu7jhXv56N/7pWMX/H1wVXb5rWmBEaZDN2hTPE2MX/zbyzmisMKG0iz7M4htzVtmqgJZ7tdds6RQZ8OZDlDanCDRN69ByoKAtcpHg7ziyDp9Lij5+lt9PrqurpO1IxZoQatxUbCLQJhbC5I6b84jiZw2R6lB9oQFJXu8tYZbZkD+4Iklk2FW8QzvbIOHJ8L/HY1EW3aAEv6k0Q0uttxaKn2f66ok8t+QLGIQxaGC5UHZIO0Bc36ns/lTS1utzHP0gGQqzKAJC2ArQmMjCcKLawoSOYC37zkcEtSjR7JpdxM4bnk0gK0ZxSGjXZpHtghsEZUaek0NDRnG6Rtslv53oY/ZNuL0OvM/zgxKmyBxj3A=
X-Microsoft-Antispam-PRVS: <AM2PR07MB0578885672911971B00C7CB188F80@AM2PR07MB0578.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(5005006)(13013025)(13023025)(8121501046)(13020025)(93006095)(93004095)(3002001)(10201501046)(6055026)(6041248)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123562025)(20161123558100)(20161123564025)(6072148);SRVR:AM2PR07MB0578;BCL:0;PCL:0;RULEID:;SRVR:AM2PR07MB0578;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR07MB0578;4:pN7X34ekq45btAPwRkcle1XeP0S+Hkt4Kwk70k5P6FiZR+JUNH69uwI+i6aKDiIvOBDjSn5HXFVVBDjF4CaS8PMSKUv/jOMi/RTX2xoMpriHEjKRvmfEK83XPR6KAeeAnWMOqWqyTGrt2ljSk5kfA1EnGd62aN3Bbc141aKhubo5ZZHtCvM8kT0kMN4J/0hPU2v8DxLce6oxFrwhm3Ho9b3OlLcgieIHoUJkDPxZcsInXgIHarvQmTtq5yNPvxcD06R7wbBQTKlTqUllr+VrViS3Rj8Yf+JS2l1sw5G6qpHmMdaI0HRig3ce0/L3kunIPmMvRMEMCIvthS/+jUZ2EIfSpxdY4aNcy6nY1NjUqGJYTE3oQ3kfO74aS6pp1UyvoQDEsqA6SxknA7MxAioCok/THE713nCiwjYOHgiSdWVzOaiOkQNx+8xeeZVdghV1IhqzRZ3P9jvZQOSLRKrmcRlqHRICt2CKSxgoSncHYeUHaHsFUqhrxcX3xGPluw5WtSjSehoZR/46ShuL2VVSqghH+qeY5i6TGDMvKeE3rG2Ki/jtAXBEka6Do5FWEtC4OkmozVLIMH3qLkES+wbM6+3OI0jrXVlmCF1OL45enGyW1lnvH6gyfULJtOiuArvjlrcfZD0XIH8A6+1SVQw9oZzkBL9TVvHKFuf9263caXUNPa7kvX2/bMF+bmVXH8xUFRrpa5uxNuWFbOZvnjWXKI8vsGXOiQ0/2eDPWKbqY6pnrq1KGtWLnDNc67uVBh21pOEY9KRXyEHjVkHd6qWn4YOhtSPfx3XEXmTpSqhr+Nto/sWwujB6AIVHjC3LhwJCAd3Q+H+61tWTWhQ3x5hfMGSkkjmr45juUsYF7er+tOY=
X-Forefront-PRVS: 03152A99FF
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTJQUjA3TUIwNTc4OzIzOkp4ek50QmxRZU4vK21TZlRmWGl0encxQ05X?=
 =?utf-8?B?dXdBQ0hPWlpidWtyak9tbVF2bWFMelRkU2tQWVdpU1VnZWpTc2dOVXhSeWVn?=
 =?utf-8?B?Ky92RGd4Q0JJNjhaMUpESzJYb3IxMUhXeUtxKzNqSHV3VGs4VlU3YTB3MTJW?=
 =?utf-8?B?SHo5U1VqSGhBZkJGNVhOQ1B1ZFBsRlQ4a1lsQnNEUCtUcHEwMEQ1Z1h0ay9W?=
 =?utf-8?B?dHloZXN6S3Z0RWxHSmsvcVF6QkVYSnNYRFl1YnJhODB6OUlaZG1od2g0dXZr?=
 =?utf-8?B?OUoyNDQ3RlZsM3ZHVVdpcGlqV09kdmU1SmlmcmZDUFRZVUdwSEZyb3locXM5?=
 =?utf-8?B?UVdYWXhzWVpPVDkwQ3JwdDVlQVhGRXZjSTRrRFh1bFJ0VWhjSENOeE9oVmho?=
 =?utf-8?B?RXd4clNNdmVZN0pkaHFCQkFPT29NL3NXRlFhM3BuelVIMjBoajdTYW5XcHhE?=
 =?utf-8?B?L2VrVXhtcW1DN3c3cHpCdUtuQjdCZ3hHbmRTcml3V0Q1WnRsRzZkMU1yUXBQ?=
 =?utf-8?B?UlVYcjJBeUNYZjlHdzA5Slo4bzhGWXE0MVRvOGtkTHhiNXl1bTdWMVhydzNN?=
 =?utf-8?B?R1dDZzRtVGtndEYxOCtqU2I5Zkt4djlQWHNEQ1djOW81U21tT05rS0pFM1NQ?=
 =?utf-8?B?YW4wVXRNMlR2QXFkUzdJNkU0eWtqSzFFZjAwYXBJK0wvZlpjdVJOc1BZSjNX?=
 =?utf-8?B?RTllRlpCek9rcTdVUVBzWVkzSDA2bGVYY1M2RU13bUR5OWUvV3c4WjVIR2p5?=
 =?utf-8?B?NVhMeGNnOTBJV0liNGM0Qlk0eHk3anU2cUsvMUhlbk9XQVhRSmZqMmIvdnFt?=
 =?utf-8?B?VCsvb1RyK21SUFdESHNYc0lJbkpUZHdOeC9FRkx1b2dDTGhvVWJjRWtRK2VW?=
 =?utf-8?B?bHVUTVExTnFyaGVGZVZOV2JrbkNvaDhVVFQ0NERTb2NKZ2hadXFUaWpPamVi?=
 =?utf-8?B?Rjh4ZHEvai9rdzJtMTdrWVVxZXF2UndXZVJuQlFIUVhCbVlBcTVjdXJqemcx?=
 =?utf-8?B?VkpDeVBCZVdpTERFUnhMYzFuWHMyVjRhNlNpQmpvVHhXUVcwbHpUbmNzU3ZY?=
 =?utf-8?B?ZGF0RWVIdmUrK3NaWGhGcWpRY3pHZ2JSa1BhUjMyaXo2UjY5NVNEK3NPMThr?=
 =?utf-8?B?RDB4MkRlVkVEdkhBSjBiUEkwMjNhbVJVTGtMU1dMOVZhdzh2c1EwdUoxTjlW?=
 =?utf-8?B?QW9FakwrMWdCL1JnaXk2MVA1OTJRbHVBYXVadXdaRnp2NVZCU3kwYWdEWDRu?=
 =?utf-8?B?Si9HUGQvUUVxU081Z0xxeDZXM21MNm5DZVNsaFVmRURHODk1SXhuZkpQTExp?=
 =?utf-8?B?eE5TNS9adEFtUFJBTHZoRXg1UFE1QWhUbEZzekRrLy9GdUZ3Z3FsMlpmVXhZ?=
 =?utf-8?B?dlZZT0psMlZRYzB3bzhqN3VuekQvL1dYcDZWZWR5dE9PaDhlMDE1VUZHclVq?=
 =?utf-8?B?UDFMTG5HRWVpeERSSXhwYW9nWEJMaU9tckNLeEp0TXhzNytaYVJxQlBLbXpC?=
 =?utf-8?B?cHVBOWJUMkZXRzBEdmNaV2xvMG0yQXYzUTZjRVNlenJmK25tZkZDbmdWeVhX?=
 =?utf-8?B?OStMSExydi9IZTFWaVFiTUNYT1Z6ZUxvWjR0aDJxeldVQ2h0YmRJVE5ISUlZ?=
 =?utf-8?B?WE1yTFU3NUNnSXRjY09nLzV3dXpMR2E0SFpqUHFaYzRJZm5HbmRtTVNXUG5p?=
 =?utf-8?B?MkZSbUJLcGw4MkJWeEZDWkhNczhybFhOWFo2Q3gvdnFud2Z1WVpwNkNmR1lp?=
 =?utf-8?B?MHIxMTJDNWMxODBwTlU5L25BQ1Z3cDc1UHA4OWdyZFZBNG5OZ1pYVFVLSHB3?=
 =?utf-8?B?NmxDMnJ1VE1rTHlwTktzdXZQaVVGcER6L2JHWG8wa1pSaWc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR07MB0578;6:M72ZbpIeFpjlsiIPkS13SkDeePU2q5nZ5sNXF7JWcK/nmsnTFKUqgs4ubz3y9GVd57Y1i+p6E1mTk4KCCYDhbBlrvqzD8opQQYQmHYhjBmRdk2k4YMBpiLDj9bp4GsXIszQ7xsbWOlhM10IlYchjyXKh/nMAaVCuoB6g2BaUYQWsyew2kCEO5Vj8iOm5IobKYRVud45RyNsJfYiz6CdKyc77Ep4IvAsKBkTsQ5Lw89WAZ4ew7wwgfC1GI6vI9WL+YaEgDSNu/Mq0M67C3u8tp7jnk1JgyLw2m1amtsc1Xywz44Qp325N5gIXats56/BFu0CxPCt572fjQbrRKcIIWaegNMPXQXyFKF0iY4R6RPVEb/dWlisD55yo4kJZxe0CPz9Rm1sw6iUT2h8E310FW2hqlugyQzbm0V0h+LM4qrTuxymH1Kmy9ArDATiB5reP7wUNLzHBDc4h2dTdA2ndB9mFtCtR2DgiGibleNYPCYI0iA0Zy/FYEM1MdQ2qZFCOVOROG8yfEsb3m3oUWji0LA+0V5nkDlZ6Cl6tK58JLu0=;5:cuBgt20ojLFCEyWJ97KyC/9HL+p+aHD0zcV3iQHLg0Xl0MDTTcOJcqZaKW46y2VAoQzDuG+8z5vY3GkIXvX/9E8ZM4vAiMj2eilYdTwm5JRXcixofvvPEOdTnKzmlNcvIY/qiMWzL0lw63igLp2n7Q==;24:bzEf1a2FGS89AKx4EPttU2qAEfIsa49VEb4gXpKWVvt+JtWbjevAywA1cquCC7/oXnej6DzRJ/H7ZwQKt/xfSf9NrhyLVF0Omdd1jyLxT+g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM2PR07MB0578;7:kDzKMMIAca6jGYlulxafYvlnGoU4DpoSbxxC1C72+DJNXSkaZ9W/eDVEWHuCWeogQsbOmno0vhjshfmwKFdjfT4HhesljJRTNxiRmV4uTY3NkjP89/Rnvl4CJjeRMxrFd6iQTezZ2MqBeHFcVzBLBXKLOI/eRi2kgdJRdewGxj8Ls9zeR38sCvRNtQlhQQxSL+3UfBoDK6pgq93MD8WKaVwPcHvhkDLEX+CThDlYJiKNh+MBKjfZ3B5Hq8udrqKcWRRH+grFLdU7nKmcHeEeWTyw0agSLuRBp3INHbilHfdogJqJc/fhslMX4OiRc/N14GBaNwKP4zfhHhxATyrtRg==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2017 13:22:52.1296
 (UTC)
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR07MB0578
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nokia.com
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

Hello Serge,

On 22/05/17 15:03, Serge Semin wrote:
>> I have an SGI Onyx2 and just recently acquired a working SGI Origin 200.  The
>> Onyx2 has NUMA issues yet to be hunted down, but I got ~3 days uptime out of
>> the Origin 200 running compiles before powering it down.  Mainline needs 2-3
>> small patches to make IP27 workable, last I tested.
>>
>> I'd have to look at the IP27 code again and see if I can make sense of what
>> it's doing.  I think it dealt with either setting up memory for an initrd
>> (which I haven't used in over a decade), or it's for the NUMA stuff to discover
>> all memory on each node.
>>
>> -- 
>> Joshua Kinard
>> Gentoo/MIPS
>> kumba@gentoo.org
>> 6144R/F5C6C943 2015-04-27
>> 177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943
>>
>> "The past tempts us, the present confuses us, the future frightens us.  And our
>> lives slip away, moment by moment, lost in that vast, terrible in-between."
>>
>> --Emperor Turhan, Centauri Republic
> It's great to hear of your willingness to help. Since both Loonson64 and SGI IP27
> problematic architecture-specific code will be appropriately altered, I'll publish
> the fixed general MIPS-memblock patchset within two months. I'll also try to
> involve Ralf in it when I'm ready, so to make sure all my alterations are made
> within kernel arch-code coding style. While I'm working on it, you can still use
> the current patchset for some limited tests.

Please Cc me in this case, I should be able to test on Octeon MIPS64 platform.

-- 
Best regards,
Alexander Sverdlin.
