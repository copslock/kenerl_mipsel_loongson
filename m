Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 01:34:25 +0100 (CET)
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:30459
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991111AbdCOAePeONm8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Mar 2017 01:34:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PVDm4y7uRjzUlEr4aB6m+e8YfuJjlEhURw09l5KcPBM=;
 b=W9PYd1ixKtjBpjaUpAFlaOFuGJSF55hqB32ca3pjBfCwUh22oJWf5fhK8d5aesLbDR8g0+b/77+rQCf9OrGsltKg2nBSIWz07toPJU+jcatgXi/SSApzwT6GmhJ7WBE556GGUp7JNPg/JZYIQexeI8oIrAS34oCcVmYb3OqoqCw=
Authentication-Results: cavium.com; dkim=none (message not signed)
 header.d=none;cavium.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 SN1PR07MB2430.namprd07.prod.outlook.com (10.169.127.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.961.17; Wed, 15 Mar 2017 00:34:07 +0000
Subject: Re: [PATCH v2 0/5] MIPS: BPF: JIT fixes and improvements.
To:     David Miller <davem@davemloft.net>, david.daney@cavium.com,
        ralf@linux-mips.org
References: <20170314212144.29988-1-david.daney@cavium.com>
 <20170314.172937.1289357366273291363.davem@davemloft.net>
Cc:     linux-mips@linux-mips.org, james.hogan@imgtec.com, ast@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        steven.hill@cavium.com
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <1d09f001-aa15-e3bf-be85-a13b1132a12a@caviumnetworks.com>
Date:   Tue, 14 Mar 2017 17:34:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170314.172937.1289357366273291363.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0038.namprd07.prod.outlook.com (10.141.194.176) To
 SN1PR07MB2430.namprd07.prod.outlook.com (10.169.127.142)
X-MS-Office365-Filtering-Correlation-Id: 1de4acec-b4c8-4f33-dd05-08d46b3afdfa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:SN1PR07MB2430;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2430;3:WR4vQef5QsmnSZS7lwv8MxeXmQAHA7iAg2SKADliauyUt+1Ji0EZcWhUzPg/6IADem8Qq0rF2RObIbttlv4+XUrnk7JBqla9MZPrOm8jSlG8hHSsB187UJaeGjfVIdOPzotgMuVzyqhEA/a+U/6p9himiJP4unEhhe2T318Cm1bcQb7CIuJEovzRI/EBca6xXFtG7RzPiQj72f54SqbwOIvGA/J0hyxi9vwZgvhm09kYCR6UJ4VhJYSn/TiRJ5WJeI8zScjOGETWx+tZvoYx4A==;25:r+OzTrnMh6qfNCEgoTsrarX++oV6dmTE1+Balo9jQ9m4+TUGCbxMVxwLFV0ckCTPQL2Spclq7xF4IGvh314iOzsGu5SGPghXNrm5ZaBAIfSYkp4TYqntDolCvbaxCzux1wy1Q6K0wxDtAZzyEa2nKTygMUWSXc2Yz6NC5XWtF+nC3+ffbOP8vB1d53xjkxpEgyhsCDr4weu9Uqo12IEEqmZzkzN9h3+XqvUHwohvzhDfd9lUR83DYDNW2YGkM4hGBiH43UvBC+B5iDkN3oLiL8putpH2m4dVwN6cBOjXky94z5ZBQyG/JQ08so+flNGtnyBp2Vud8xITyuczshjzVAMRT5bDIkNYgYW3A3OyZXGIxT0aXkGQRr6H15xH8yFa74MaPaOGcOCN5+Jb0VTyM6jd7P8X/lC5yokBhb7gqsZ6wXwiBaaDN7R6Py9j5TgfxDkjIxK21BofO0+S78UIKQ==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2430;31:sofLYKJ+i5/108oVE5ooQK7AW67SyWqKGYiXxSxrQHGGwRzdAKK7AaFHIdQdozGkhJd2oZs4+kQK+g6Meh1SqFw12H2I4hDa88VxvTnCJQi49yY6GDmToMgR2jlaCUb5csnGiedsjfoKTBGM1tsTtJfg5ndCq2ops1J03wt72u67vE2CyaFgGKlKFG65hwU323NGBWCf+XYW5JsWLaCaTyHIPb3kd9YjoeJoAbZ1WIc=;20:MJixzYU5RFsLA74jou5nI30ktlvhYAlQYahb/fmJQgypDtzHEYXY8I9jzw1cW6PBAhEakUfYHGK5vlarfqhUSfpp+ozED3D0kz6udQShWFZzh81vLlptkEFE8iUHgX5Y8zQLv1vEqDwz2zqV9pQlW4WvQa1Bx+KZDUhh0leNdK7vAvRtj1hMml/5Du/9nxslFnnmwsgUtPHGfDPelvnLdNUYrXQN9BSVZjmHHtCp8Pys2vmyjU4QC20Wmk2jzplcL5qLgx4RiUJnkX+INZ8Hzqw3mc1MJvAGPiLoMMRUQhpiYmfs0IgUq4QxAhncjaFH64+SFrTyDUE5oozvz9m8F7nxI8eXrnKb3RqE9xHqnRLsIo1A+29u3wHeteVXtEbmw6lS5JqK1uw3jwQZ6E2+HXsw6CYGAwTgYcQjgnOufpWJwTtI0yVFy/WhAgHwR7WKJ1BRbLj9MA7GVi6G+xofwUPF2SLiscUzbHEJv6oELlL3+kdVQdO8+rxZYFwu2Jw3EW5C3EabUCTSsntZ1xQMjJKdP9mocI38ntSZfAARwc0BKBHNGwMzz0xgzOCnuIaTfnpH/nUwJAapoFkxfMVsSn7YOU7WdYMhNeSgMp/t/rE=
X-Microsoft-Antispam-PRVS: <SN1PR07MB24307716412089BBC673BFA297270@SN1PR07MB2430.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(20161123562025)(20161123555025)(20161123558025)(20161123564025)(20161123560025)(6072148);SRVR:SN1PR07MB2430;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2430;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2430;4:HhEeJiv/ckXL6O2WbijJm9/v/EY77GT4oeYHuO249QGLynqNDyDnf7zZmoz7Lv25RNg09KuiOcDbRo3lv4LSkp191GXngGaXLK1KSYLIFk3uohw3SiU7+fNY/UeH39TRudXDPaHnHOWxsYTwPx4gjZTqtU3wR/fon5TFKRhVjA/nIc0n/ZUovt53YHdiIQYH9bmTNVhusGQyAHOBVoVDFBysocts8ubn3hmerxEQbPkpDywn1wpyUksQcBkPaDJOVOPK2XVoCu0VskBJ7EosPdpjs5uYKQKTVokS28eyFYacEPOueup7/B1Z7Yfa1bhDw+qmfhletvetEzkGWEZqiOrDNdAZRGLX0XEQDtBeAK7xmMJXcveCZSqqdd92sT9tjAxQjeTyxTBSniaPwZuMl4K1c1ZclfEJQtdfpfZAZaiyIhNvX1h3+N3oTAFA2jr/edsn0oYBhq/V9mM1OnH6Oq5kjVOMp6la49TpxS2gMqOFOdAEx83zCJp5ASBaYxAMuF/rSJB7btEOjLUocO4ChLNkHAC7xDCPkwyPC0H0Kw9yeXd+p2MhII48cCTSdSZys4pk6hTejkE7bGxiuiDCHgj0PstpoSP2jsXVJB/sZqk=
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(24454002)(377454003)(8676002)(6512007)(54356999)(230700001)(36756003)(38730400002)(110136004)(53546007)(107886003)(6116002)(53416004)(83506001)(31686004)(3846002)(2906002)(4326008)(42186005)(6246003)(81166006)(31696002)(23746002)(76176999)(189998001)(2950100002)(42882006)(6666003)(53936002)(4001350100001)(6486002)(65956001)(47776003)(65806001)(64126003)(66066001)(5660300001)(305945005)(50466002)(33646002)(7736002)(6506006)(25786008)(229853002)(50986999);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2430;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR07MB2430;23:Q95W3xASpTjrjuLqJJh394K9pKNl/qQ6qOt4W?=
 =?Windows-1252?Q?9WLPXfL/mts5vgr/PUvHrkMyMoREJd9+lZPHuBqXUTKe/BXMMV8GUFIY?=
 =?Windows-1252?Q?oZ4kvwVDBkf3l9l0Q1d85kDV931CDNdM322eYg12tKqkR6AM2s0UTQof?=
 =?Windows-1252?Q?YE1/poY2Q+1er4tJMA6oZ+Xqb0fPZzqY21+l6GwrifRMdPnwKnCZJGpw?=
 =?Windows-1252?Q?Vy7e7oWoVYSPEP/nNBYKdhaYuBocEt+JS1QlMvVSw32lkahgJH3OOJwa?=
 =?Windows-1252?Q?vGENiZGRTN1znnl9j+sw1lwFbM1ZSFGOujPVFGJ3TegSdOA6qOcZulyq?=
 =?Windows-1252?Q?zkk5f5DT8q4E+a0+CdYSIT/6xko05iCl1BzH8xCQuewfdEDl6YX3aP6K?=
 =?Windows-1252?Q?Cw63gBSZ7IEZH3Whke4NflDEMrUtO/AInEu9DrJWOdxhPws4dQUSERMA?=
 =?Windows-1252?Q?aRYR8y7W2wdGK//I350rT9m9Yhr1uX6gauaex9iViVU+eAnULnK329ud?=
 =?Windows-1252?Q?PZAU+zMcG5tA5AG6w0+P6Hw3AoEBW3y9CNhZBCSwXHktUNESi1PElvpS?=
 =?Windows-1252?Q?mUdPgNL7+kLdENNZBQNZM/AKXh1Zj8m4BpMDPesyhCX+GGLADKD0GXsv?=
 =?Windows-1252?Q?fyTSVXPUp1mlh9HM8JkPgmImefMaMN0nkJcB8VGmi9M5fqs8/6G9Eywc?=
 =?Windows-1252?Q?Hpdx5kylIakZrss9OTrJZeGN3gHl9VXYcq/DzxWANdX43NjFQ4B4UeFG?=
 =?Windows-1252?Q?uUW3OZ+Kt6OWZ8ZRvqze0T5F1zorL5gBu+dclH8H7ehah4L2APoI0h0a?=
 =?Windows-1252?Q?5BcxkVP/Rr9CHmMRZ4vZSsSBApOayUA6VlZzTmY/Nn6CiduU4lQglmZW?=
 =?Windows-1252?Q?3iYZr6VMBgVEoqhHp2b/PGv+sunJpMf33LiPkI/fu0j4kY5FTh5yr33J?=
 =?Windows-1252?Q?ApfUfDoH55ZQxvc8qTSUgDtv81ju2yij9L9QoZ3sOMzpwBwaWXM9WJi4?=
 =?Windows-1252?Q?O7bCCFyJ87UU5Qlr8YDi+pnmcF2ghcvAuj2z4fz46oD32P30zZcyqA29?=
 =?Windows-1252?Q?7adfqI/XpdZ4EOTYrGDEgFjDUcTrqPbV0tjPKpFsWMdMxRD/Mt1IlC2S?=
 =?Windows-1252?Q?woDJg4zDMAavIBaxvvtGKM7pH0sylnSgB4q0U4zNe5UvVBRJjCnp1hKY?=
 =?Windows-1252?Q?ol10UKLKtUZFIhWPJbOO/novTOIPJB/05dze0cJXsyDxqMhsM7VSGwOq?=
 =?Windows-1252?Q?V1acgs5wwmja/kDpHX5wkx5jZXHkI+fS+PB4kI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2430;6:7SjCLvi/lNDngyCi1MuCaH4iDdG4995ehXxAcBTJGSXmnxUkC/63o/hpuWi8I9l7QMVHwVMyeLGZpIBQqMgZseVARPvqfSJqWUFnEfKGmwben95SOOdjmffRE3kNALv+fi+dc5Jt8hNuYs6SWeZg+yqlRZ2k2o2+VsTZkc27befcBh1zBrobbOD+r2FJkJcOkI4vJMFiDim/HUdHbkwDvgGmODHYncSzZ7YnypPiHmmNFlu+XNoW78fiabaP/2w8v0sxNfCrGqmYgMUZNhm85iip9slXpB95Rd5IGAOqRp4WXgF0dGQbA9amJ7NAEyeYG0ubntjrwJxGg7vd9ejoOrf7xS3ClmzB9mJp+UyHO9G+ySQpPmakuBnBJC4DZhtJeK4Bb+8LBREEuQu1VPQeng==;5:Px1+7184wVP7v+LGyqbIbu+QkQGfKtGgM9AKV1SMnHmMeaFkO1lIbfsvOysxiE0KuRjx1pseiuSO4bL/EMyiFC4ABeUy4nUMZ3hTL1s3X2oUqPwkU4FbkDOgAHkhY/vDtfCIzMGBfGNN2wflsglA5w==;24:F/X4PLu5gy1uH7ICFslPRbaRcjgBDxUvDmxaooI/vWLRDhworHyVK25gbe65SpRB6qCXOnPSEn6Lm7zEn3pEsyVFVgdCC4Cx8hiR2rzuXbo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2430;7:AutoikQpdn79BCahmLwaxylaAP2hHuIp+dU3d0ssDKNfO/fu1LKzsubs7SLGviAk+5cUM/1bSULb4UZUF6wBnWSfUZz2jdfGhRm+NfcRcIITPJGwYBiRLRTvAwI40ip0kk/rZ9B+g+ozn43ue3ne+8Q+OzWkHM8ht8MqeCmWdZ+OL9H4q3Bzu2kP9qS1NxO5xUsJ+6NMZnDS3ZIaHf/ae0TbBq0BuY9i4nqkc7oyS8l3p+pKxyyYZ0lEEQRcuw9lYLDxborTDpa2Durh154xB7fpPS6EP17qk0cJtZ9baeJrfUaNn++e51VScFbxzhPwCPkSsYtDq5MeZpjwGSbm7Q==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2017 00:34:07.1621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2430
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57273
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

On 03/14/2017 05:29 PM, David Miller wrote:
> From: David Daney <david.daney@cavium.com>
> Date: Tue, 14 Mar 2017 14:21:39 -0700
>
>> Changes from v1:
>>
>>   - Use unsigned access for SKF_AD_HATYPE
>>
>>   - Added three more patches for other problems found.
>>
>>
>> Testing the BPF JIT on Cavium OCTEON (mips64) with the test-bpf module
>> identified some failures and unimplemented features.
>>
>> With this patch set we get:
>>
>>      test_bpf: Summary: 305 PASSED, 0 FAILED, [85/297 JIT'ed]
>>
>> Both big and little endian tested.
>>
>> We still lack eBPF support, but this is better than nothing.
>
> What tree are you targetting with these changes?  Do you expect
> them to go via the MIPS or the net-next tree?
>
> Please be explicit about this in the future.
>

Sorry I didn't mention it.

My expectation is that Ralf would merge it via the MIPS tree, as it is 
fully contained within arch/mips/*


David Daney

> Thank you.
>
