Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2017 18:10:23 +0200 (CEST)
Received: from mail-bl2nam02on0063.outbound.protection.outlook.com ([104.47.38.63]:62496
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993865AbdEZQKPoNHA0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 May 2017 18:10:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=67dqyw0Gu62seM7eh5G0eQR2HqsQQ0JJNkZwOOrfprY=;
 b=QlkIrfxjCYWroh4wCmyt2tGR5NU2iRZjYRxGxTIfBeCWsniteo4dZnYceNQuAjQypdHfNzLwYDIk57BJ/efNj+YODvd27HyVB0uwXf2dxSwCAR5uyzyQ1Wr5fm6sYJVx2hFzvEM3Pq5fWi9eIeUS1IA7JvoZ9hG6c1bjB2FQzWs=
Authentication-Results: imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3498.namprd07.prod.outlook.com (10.164.153.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1101.14; Fri, 26 May 2017 16:10:08 +0000
Subject: Re: [PATCH 5/5] MIPS: Add support for eBPF JIT.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, Markos Chandras <markos.chandras@imgtec.com>
References: <20170526003826.10834-1-david.daney@cavium.com>
 <20170526003826.10834-6-david.daney@cavium.com>
 <20170526022300.c4gtxhqt3tyiukz2@ast-mbp>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <dc3e42b8-e2f6-c678-6658-9789934240fe@caviumnetworks.com>
Date:   Fri, 26 May 2017 09:10:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170526022300.c4gtxhqt3tyiukz2@ast-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0026.namprd07.prod.outlook.com (10.168.109.12) To
 DM5PR07MB3498.namprd07.prod.outlook.com (10.164.153.29)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR07MB3498:
X-MS-Office365-Filtering-Correlation-Id: 9d454a01-f68b-4456-d104-08d4a451ae28
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:DM5PR07MB3498;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;3:nWt/pJL1c7rNOZGCVY8qAKe1cncoCSSaanHZQTKIKfvo59BZpRqY7SLBltNfmZaotrzemnVWoI3iTPVO3Ush0LITmA8izb2oLNP+z+LVcI+2dC2+bdyTP1wRF0uOEBOhrNN23+gaVtJelza/Y29C76AO8mCgzYJB2S4Rzo9WhZPieZaauf+g6mIylMJS//ZwPxTIpHsyT5Lh2Ht7iuvbnIiLPPtra+1WMrvSKQ6bwCRpWDjSa4tiZGk2oEvBThZA3nYYna8gxPNUQZoNyosgjj/GVEQRn7HACTHx2dFtAePoDjsSpkY3IqEzX5Bf6CXo7Ky/76QCyqO+KCCZFIhIVg==;25:NwTOjJ0DU86zJ/pbj9EZDzxiZNnJ+/Ou39CDRXhnhQ5/33kU9HUR72r9NkL5nJd15DWqARxIFTz0bJtSVQoDFTXzJZTeX+/i5Tghrm0JUG5jxkj5zAgfWwcX9fTkt8qE21+RtCt3ve4hT9CoVTUER0LEwJayb+FYFiqEkNzrSTs0O38fjEtOK14QIcenMGvPIZ6VVfmC2rCabBkqX3e390uCYyhTkzZrNeQg7eZdRAtyjw0mqT9yNqNkknA7a1XOy7FtiWDH9SCJ8o0Ko86vKAsDl8DFOABnmfCVB5u9eNjMg/vDs8qFUPjxrAROJHlI9s8XkdfXrd+a0Nep2j2tR3Ox1xMI3ymvqHdzy0jySp7hbHNCPJ2zZgL4wO4+Mf/DhAo6LU7f5jTm5CXDE6aCfAf7aROOydEFS2P7608ZyIdNyc/gF6nIqskYJ5TrSPG7zquZgBupI4ttnv5F0fgaL0VdAKBB0/z4J8oIBXVpwO0=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;31:akFFm9DYnCwWzF8Iq5oLp6+SkDaQYD+WF4UnrZHJGee845vYT05PH9UiXWjQFZUMGP8ZWsOxIT3dBMfol24+7DbwFSANZjn/9uFdfY8FcF1kDXD/d0uMkphkOzef/VYmtu3p+uWdnDLECsdiLuLT2L37PSoz7ZEX9U8CY3RGYSUemKs/UFvlaNdVRb8bOTCxYFjWXowoDc14HCvDc8a0g6CwPv9/YIoFJ6T2z+DXO9s=;20:z9yl2iraeJV1mRVZJBGOeMhMs2IaZycoazmXbEXpKM0+uGavQC64aEsCedl83K95izBimnFvK2ExSWpvIk9EkYyjoLzwHZSLwcuCYDHFpOCwScjCyRFJbYFZE/W8eASWKTtEaGdDERcBTdarhrmyQJ4iF++NuhoEDjvIwEgdAshx+5ksKO5axrlsi0t+XfGHUs3UOd6TlbMhGzKU0Cu+XdCd9QHjiuDMSo1Uag1z+z1UHm933c4ShRUR27Dr+2e4njzhYQn6LjWR8DyvcDUP0mXBvEdy6UI4duTJ9vxbyylJdSwBxOoOvTQM8R45bMZ59bNwxxUeQkcusXImoI6sG5adZleLXNglzepR8NyJKB/FB/ewUHsRL5cwUjX0Gxx9FMxdY5nhF/NyQvug8B7pj+j84Q4ggyKflO01afsbbrv3nFboEBc2xMJNGa/Nr09Vo3vbAPxG7iBYb37RSfhvSJgvmss4u8Z0fsiyiAACIEsmxAPDE+OrSEhx9U3tdgPMuoWFBAy+xltgVbEgGIKcl/zF8KJFOlcTW4VOOTYTCfYAiei1FZc5Dx6mKaHIR5Ek+aMpmtVd5XvDZSmXPuz5kGMM9ZYo4KpK7ziPutvgzO4=
X-Microsoft-Antispam-PRVS: <DM5PR07MB349863E7915830D88549A95897FC0@DM5PR07MB3498.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700061)(100105000095)(100000701061)(100105300095)(100000702061)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(100000703061)(100105400095)(3002001)(10201501046)(93006095)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123555025)(20161123564025)(20161123560025)(6072148)(100000704061)(100105200095)(100000705061)(100105500095);SRVR:DM5PR07MB3498;BCL:0;PCL:0;RULEID:(100000800061)(100110000095)(100000801061)(100110300095)(100000802061)(100110100095)(100000803061)(100110400095)(100000804061)(100110200095)(100000805054)(100110500095);SRVR:DM5PR07MB3498;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNDk4OzQ6bmFZWG04ZUZNcHNiRVI3ZTZzc0NtVUpEZkFy?=
 =?utf-8?B?N3g2QUErZXQvdE1uUmlSVFBUaHZyOExNaVVzd1ArY0pSNDE1eGw5dTBoSGMx?=
 =?utf-8?B?R0ltZXI1UFF6SFArK3FLU0xJelNPdm1uOWFnaWVBTkoxNFNmekNOdzd2WHNj?=
 =?utf-8?B?NFRUa0NXQURkVHVsSkVxU0Y2OHhtUGxlQkltME44SFpNYytucmxCL01CcEd0?=
 =?utf-8?B?ZzN5MWg5NTR5UUlxTHhpWUVCMkJGSjJacVNDdEhZcFZybmxLRVNvOWdhb2xK?=
 =?utf-8?B?QjZURjdFS2NsdVdhMTdRbHcycHR4N002blpicDBuS3hjL3g0Z0FEWlRqRys5?=
 =?utf-8?B?bTYvMnRsY0hoTUhndFZ6ZTZ3V2pBeStRNmhtY2hpd1k1dzBnR1pYbHlxTHNX?=
 =?utf-8?B?d2MvcGY2ZmlsVFA2VzRzc2lPd01NSWJrYi9FYlVpSzlyelpDSTVVNzM5L3cr?=
 =?utf-8?B?NXZzcFJtamJjakVQbGkxaldoWTRiQUF3MElYa1lNUVhhOSsvL1dHUWxvNXZY?=
 =?utf-8?B?T1VxQmRsL2VhYVpCVnBEMnJ4RDQzTFZTTFpzMTZ1NkNObnl3L2lRSDdQaUVi?=
 =?utf-8?B?NE5nMTV4aGZrZGxub1Y5ZVo3TElRbWI0Y2liSE9FN0FWL2ZoMGhxR0dBeVhB?=
 =?utf-8?B?NHBET0NNS0pQWkNQL2NXdmNHMSs1dVpSRnBvN3lNTVhGVVlZNWtsRm5NNDlr?=
 =?utf-8?B?dE5IZ3FxWEZwbG5BQlZoY0F2ajJmb1NSTWp3ekUxVkhSYXpZVTZFOFNjSzUv?=
 =?utf-8?B?N21RZzE5L2p0dkNxS28wRkd5bTNSendJMlVXcGpWWTVDZzgzcS9BdkEyUzBU?=
 =?utf-8?B?RHFXR1QyZzcrOTlGK2JwVUY2YVpUazFiNHpyT05EZEZzakVvdS8wZXo0a0x5?=
 =?utf-8?B?Rm54YzB6T09EMVpZSmp3TW1CWjF2TWg5dFRpMmNoQlUzbmgwOEdYWHhzZW1B?=
 =?utf-8?B?WmxYYVFDeUgwTmFEaWc1d1RSb1ZlRjY4cHZQRmhqSWx6cTVEaUl3NkxLbFVZ?=
 =?utf-8?B?YkFoSWtidStKN3FkUm1ESGpQZ0RHNGdSK3g0ZHArTmN5UXcwWHFoaHgyak1G?=
 =?utf-8?B?OUg1bXZxais3aWJhc2pQR1B0eEpIS1JwYzZPVHh3QStrbDZuU1NsbWZLTjRv?=
 =?utf-8?B?UFNONGpjNnViaUw2WGJ3a2lmL0ZjOGJNZjN0ZFBXbytCcFB1dC9uRDN1UTRO?=
 =?utf-8?B?SldUVVBPd0p5SDFvMy9uRm9NcGwxSzErZUR6cVFlQ2FISEVjVlRjM3BHZWJ2?=
 =?utf-8?B?Q0ZZUTE5dGhzMkZSNlQ1SU0yakRVUHFNM1NIWmtnczZodWtBZlJwVVRDS2hJ?=
 =?utf-8?B?U0Fnc1Vqc2FkNDhrZXkzN2RYeUhtMVJpQ1RSamxRTGVoaU1Sd1hqVWxBTDdx?=
 =?utf-8?B?Yko1QjBaZW9tODBQR3MvUmVNTFRoM3lCWjl4a2RKNiswbk4yMXBwVThIUlh2?=
 =?utf-8?B?R1pPMXNkWnJIcGgzNFRFYkJqSW9HWkFWQ2V5ZkpYQTZCZ2loS1NJMGpHaDZ6?=
 =?utf-8?Q?xEtDbiC02lrBqjDQ/OK+aXAI=3D?=
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39410400002)(39840400002)(39400400002)(39850400002)(39450400003)(24454002)(377454003)(66066001)(83506001)(65806001)(65956001)(4001350100001)(8676002)(2906002)(81166006)(478600001)(7736002)(53416004)(33646002)(31686004)(42186005)(47776003)(5660300001)(50466002)(36756003)(6246003)(3846002)(6116002)(31696002)(42882006)(25786009)(2950100002)(54356999)(229853002)(38730400002)(50986999)(6506006)(6486002)(76176999)(53936002)(189998001)(72206003)(23676002)(53546009)(230700001)(54906002)(4326008)(64126003)(305945005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3498;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNDk4OzIzOjZxUk5XNEU3T2ZhK25VS2ZIamFjU0hpa3Vw?=
 =?utf-8?B?VzRsM2FyRmJic3ZxY3JMUTc0aHUvRHFtbHIxb1BiSzFOeVRkT3pkdmt0cDNw?=
 =?utf-8?B?Qk5ORUFUcnNqMFhwTFdXM1dmSnZ2a04wMnNwc3VGZy9yYmtHVUdhZ1FoQmEw?=
 =?utf-8?B?QlJVdjdZc3NLQzU3SzZBVlpTQUo5dEVhWDRpaEJydlUzWTBlRlkyeExwVHBR?=
 =?utf-8?B?dXlpWVVCUk1zOTdwZUQwdzlpb1JqZ0ZwbXI5N0wxeHhoektEQklCOUo4TjNT?=
 =?utf-8?B?NDRjdXdKY0F5WGdlV1pLMHowR3JpZ2NQNU5hdHMyaitZYUZVbnI5NStqdC9x?=
 =?utf-8?B?SW1QdEs5RlJ1M3BuWVB5Q3prWjdOSExiYjkzMHVMSHZjSTFCMEpjNi9EaVJr?=
 =?utf-8?B?eVlDZlVUZEwzSFFuOXFvTkFFcUxoZHV3OTltR0FZYWU2ZnlUbUVwNklEaHd6?=
 =?utf-8?B?L2pPVk92U0NpV2NpZHc5Mjg0N0QvNzZ6b1pXTE84eFdNK2xkSHNaOGgzMTQ1?=
 =?utf-8?B?elJQWDRubUdmVE1EQzZZbGt0cHRYY1BNbFZBbVNLaXc0MlVoL1Y5RzI0R2Uy?=
 =?utf-8?B?ZjJ5UnlrQ0wwRXFUN2ZkdDZaVzlGUjhHNktSRlpTaDBwSGU5U0pFZ0xobmtp?=
 =?utf-8?B?cHNIUGJJREVvZURoZFVtWmJKWnB5RHRzT3docUl2Z2ludjJiS2Evd2dyblNR?=
 =?utf-8?B?TkUrZlZsVkVuQ0VBMzIrZ0puckhDdUJWNEMyMEY2WWloS3NzZFNoWGZabTdy?=
 =?utf-8?B?SVVvd2RMaDNKa0dUSzhWTkMySm0zc2lZSGNkdmVFOUI0YzlGSDBTbmRwZXg3?=
 =?utf-8?B?MHNJSE8wRUdmSDZROW96dlZjOXZSMVFuQWpUTnU5MEtpNWp4d29Rbi9sc05R?=
 =?utf-8?B?VVBVT2crMjkrQzJjeDRMK1hlNm4vSE1tZk93S09RQ0dvTTJweSswVFNBOXYy?=
 =?utf-8?B?dVRJMERXdCtQN0pTUDdiUVQzamw4THFVTlphM25oTEVwZ2xmS3ZOd01DOHNh?=
 =?utf-8?B?SXdUUGJjbkZ6ckdsNlFzWVVLVkdta093NVV4czBsSkNlbDA3WElpSGMvYlRL?=
 =?utf-8?B?dFFHd2gxZXQrZEZSUy8yZ1dRcjZoY0tJWll1RHdrZmxCQkY4cm01TVRVNUJ5?=
 =?utf-8?B?Nk5qZTlScWh5NEMxNzMxNG1TV0Q1Yk1US21zSlIwSndScGZ1ZFlVd0NrWFBG?=
 =?utf-8?B?bS9LV3d3Z1VoN0JkN1BTSGFLRFZ5eTlmVXBvYU1tbm9DQ09SY2xWMlNHNS81?=
 =?utf-8?B?blk3YmJDL1JEbzB2Rkx6VXJUZXpYZ0hyMHZ1ZXF3eEZCZUZKbGwremV3am5s?=
 =?utf-8?B?QUhocmxvSlpQTFVVY0ovRzNmc1lhTWQySTNjempBVjZqUEFrbE0yM2EwdVdQ?=
 =?utf-8?B?a2FLdXNJMGx3L2NSVitkR0VyV0NTcGIzZGd4SEFYOHBMZGU0QzExSzVCM0Js?=
 =?utf-8?B?RC9pU2tvcU1uay9wOEtXUXN6WDhRRjNBUEdEUlhIZEEraFJ4NkkzaDMxeHhX?=
 =?utf-8?B?Q3E1SVpISGZCcnlSZDlESmR5WVI5MkZLeE40dzRveUtyaXNJSyt3cmFLZHlO?=
 =?utf-8?B?UFBVK2wxa3NXeHZvc0lkdkFVVDhRY212YS8yZTN5RXBmL3I5bW92Nm50aVM0?=
 =?utf-8?B?Q0pxeWYyU2dJbWNxcFhiSzRjRzBpSFhsL0V5V2lZQnJ5UFNPajM2ODA3OTha?=
 =?utf-8?B?cUlWOEFJS0tFNmtUcjdLOGRzYzQvSnhpNi9vZGwwc3ZQMDB5Q3VxS2tXZ1ho?=
 =?utf-8?B?dDZXeGRGdUpGWXNLd2lDUT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;6:5kqQlLZ06ZEwKKFpToS5BIf1tWRGpbLSZPsup5x8I2HdbmeGpROXhOP+piXnmGBjEqRrqcTrOTarwSj0xaDpUqbXaifBPIbvDbGsBjMQLIr0gkwhgQdf6Jxz3SayrH7jxAER/Zc3DLSUD2OoyoUQdeRvRVaQOY0EpPC8j8566x0pQWb2b704WGZhtesz3tao9fNRn/btyOUSyy9udlNTg2zpdRCV8Ov3iWFLBM0x7+rq/nT3gAXCmcp2h1dRkW36I+VL9dNV6rLxQBK+6fvqR+wnBy/n/4mn3aoxbYl1R04fFLkz2tinCFSkrdYJ79oz1tKz7yVpQhLE4YZjB/uXClxVC64mo++yVLWHY9Hg9mNBNJYYubnV3wDHrYuTvgzroWvpcFvLBP8yKYeGZUhZ7mhFHcPb0Ym8LVtqGNvdRYZmNfV1mCIPnFX9dSzRix3LLO/tkCqd9/9UPH4mEcxznULC+AC8efY+k+BHYOxJKhz3d5gGFEtry0HvQ+VtDBdEUQKui5a+00tFoBOMi+z/7g==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;5:UXBbFFEX+KvWqiead94OcRQEaDaOCYj9IbssNYzcUBBpqpRjXfHEdn3hsM5fXOg198PLl7wyBbBshXj1ZRUES3DSmpy9OM78WV7RIu8oRd+3Si81srskpwmHZb2oZuPkdlXG6IYrGaDcs07U3R5JhXsPTAcZ5a/Io3+956F00XJpu1vQizz8E7dm3Q1HTHzpg5WjB1doG4DRJk3DvRe/9KpqKHCl+sK4a5eOa9jkZyaG6xEq4K4OKbKAcy13y3mUwr8sYGeP1T2WJM3LEr+26wcUMMtFhBNpO9fQw2bg+NDMKxOBdE4QcGNRfZeO7vLRrHGsz4Nwawa2Zj2Jj6OGFv7G08jYeEIX9o+ZsMMzKpzUn7Sc04K6JwsA8dw5v2FEt50QooH0RaanSgyX9PLsrwsGxYUf/SC5PI9yH63PE+/IeX97vlGz0me0o0/qG14Sm9XZ8e4AczOzKFWErA+C03KV5MDyEggRKRoMT4jBd/tdp29XbwbJdMeLwb9M7HyT;24:9oy+Tvl9QnkzBc23qBKMsHBGU7WVkr7MkR3Ie2eAghUm808V/+uMKWLjDU1uATQKBArV7EskqkQ3R/2yc2W6NfGgZVmI6pu9+AbDIe81wWo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;7:mlN2Z9muZQ4idfnzolzBYDHBTPZlGpOy9BJb9D4xAFxgsDc+cgTOZ+2Y+jUEPcLB4Lo6nRSO5mPQ8qifHr73ad/bEnhTxiaeFx4dmO6FbfiEzlXKnRqzQ7y3b9ibx5ppx2kuQKiJBq779VI6BWBqpj5bDgA8HK6wvpdWyvycJ32NxnJxPq4RhBZRoIpP009ApQL7utzCdpoZOCfqgC0z6begjnr8c2eB2/2+oyfFRNDkovijoYF7m5vs6kxZKCLQ9F5AQoB+kQzKkIf0WXcUIvP7Lah8P8WYQKLZhercMtcqJDncgktICEQRtvK0GikP+cNS4m3WenG6Rl2yeziXTg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2017 16:10:08.1775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3498
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58021
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

On 05/25/2017 07:23 PM, Alexei Starovoitov wrote:
> On Thu, May 25, 2017 at 05:38:26PM -0700, David Daney wrote:
>> Since the eBPF machine has 64-bit registers, we only support this in
>> 64-bit kernels.  As of the writing of this commit log test-bpf is showing:
>>
>>    test_bpf: Summary: 316 PASSED, 0 FAILED, [308/308 JIT'ed]
>>
>> All current test cases are successfully compiled.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   arch/mips/Kconfig       |    1 +
>>   arch/mips/net/bpf_jit.c | 1627 ++++++++++++++++++++++++++++++++++++++++++++++-
>>   arch/mips/net/bpf_jit.h |    7 +
>>   3 files changed, 1633 insertions(+), 2 deletions(-)
> 
> Great stuff. I wonder what is the performance difference
> interpreter vs JIT

It depends if we are calling library code:

/proc/sys/net/core # echo 0 > bpf_jit_enable
/proc/sys/net/core # modprobe test-bpf test_id=275
test_bpf: #275 BPF_MAXINSNS: ld_abs+vlan_push/pop jited:0 131733 PASS
test_bpf: Summary: 1 PASSED, 0 FAILED, [0/1 JIT'ed]
/proc/sys/net/core # rmmod test-bpf
/proc/sys/net/core # echo 1 > bpf_jit_enable
/proc/sys/net/core # modprobe test-bpf test_id=275
test_bpf: #275 BPF_MAXINSNS: ld_abs+vlan_push/pop jited:1 85453 PASS
test_bpf: Summary: 1 PASSED, 0 FAILED, [1/1 JIT'ed]

About 1.5X faster.

Or doing atomic operations:

/proc/sys/net/core # rmmod test-bpf
/proc/sys/net/core # echo 0 > bpf_jit_enable
/proc/sys/net/core # modprobe test-bpf test_id=229
test_bpf: #229 STX_XADD_DW: X + 1 + 1 + 1 + ... jited:0 209020 PASS
test_bpf: Summary: 1 PASSED, 0 FAILED, [0/1 JIT'ed]
/proc/sys/net/core # rmmod test-bpf
/proc/sys/net/core # echo 1 > bpf_jit_enable
/proc/sys/net/core # modprobe test-bpf test_id=229
test_bpf: #229 STX_XADD_DW: X + 1 + 1 + 1 + ... jited:1 158004 PASS
test_bpf: Summary: 1 PASSED, 0 FAILED, [1/1 JIT'ed]

About 1.3X faster, probably limited by coherent memory system more than 
code quality.

Simple register operations not touching memory are best:
/proc/sys/net/core # rmmod test-bpf
/proc/sys/net/core # echo 0 > bpf_jit_enable
/proc/sys/net/core # modprobe test-bpf test_id=38
test_bpf: #38 INT: ADD 64-bit jited:0 1819 PASS
test_bpf: Summary: 1 PASSED, 0 FAILED, [0/1 JIT'ed]
/proc/sys/net/core # rmmod test-bpf
/proc/sys/net/core # echo 1 > bpf_jit_enable
/proc/sys/net/core # modprobe test-bpf test_id=38
test_bpf: #38 INT: ADD 64-bit jited:1 83 PASS
test_bpf: Summary: 1 PASSED, 0 FAILED, [1/1 JIT'ed]

This one is fairly good. 21X faster.


> 
>> + * eBPF stack frame will be something like:
>> + *
>> + *  Entry $sp ------>   +--------------------------------+
>> + *                      |   $ra  (optional)              |
>> + *                      +--------------------------------+
>> + *                      |   $s0  (optional)              |
>> + *                      +--------------------------------+
>> + *                      |   $s1  (optional)              |
>> + *                      +--------------------------------+
>> + *                      |   $s2  (optional)              |
>> + *                      +--------------------------------+
>> + *                      |   $s3  (optional)              |
>> + *                      +--------------------------------+
>> + *                      |   tmp-storage  (if $ra saved)  |
>> + * $sp + tmp_offset --> +--------------------------------+ <--BPF_REG_10
>> + *                      |   BPF_REG_10 relative storage  |
>> + *                      |    MAX_BPF_STACK (optional)    |
>> + *                      |      .                         |
>> + *                      |      .                         |
>> + *                      |      .                         |
>> + *     $sp -------->    +--------------------------------+
>> + *
>> + * If BPF_REG_10 is never referenced, then the MAX_BPF_STACK sized
>> + * area is not allocated.
>> + */
> 
> It's especially great to see that you've put the tmp storage
> above program stack and made the stack allocation optional.
> At the moment I'm working on reducing bpf program stack size,
> so that JIT and interpreter can use only the stack they need.
> Looking at this JIT code only minimal changes will be needed.
> 

I originally recorded the minimum and maximum offsets from BPF_REG_10 
seen, and generated a minimally sized stack frame.  Then I see things like:

	{
		"STX_XADD_DW: Test side-effects, r10: 0x12 + 0x10 = 0x22",
		.u.insns_int = {
			BPF_ALU64_REG(BPF_MOV, R1, R10),
			BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
			BPF_ST_MEM(BPF_DW, R10, -40, 0x10),
			BPF_STX_XADD(BPF_DW, R10, R0, -40),
			BPF_ALU64_REG(BPF_MOV, R0, R10),
			BPF_ALU64_REG(BPF_SUB, R0, R1),
			BPF_EXIT_INSN(),
		},
		INTERNAL,
		{ },
		{ { 0, 0 } },
	},

Here we see that the value of BPF_REG_10 can escape, and be used for who 
knows what, and we must assume the worst case.

I guess we could see if the BPF_REG_10 value ever escapes, and if it 
doesn't, then use an optimally sized stack frame, and only fall back to 
MAX_BPF_STACK if we cannot prove it is safe to do this.
