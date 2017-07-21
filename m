Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jul 2017 19:35:54 +0200 (CEST)
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:39735
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993122AbdGURfoNupGB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jul 2017 19:35:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YyGBRceTIKtYE2lZ3fm9Z28MykZEzEe3qVuJFVZeEFI=;
 b=WOTy5ZXELuJudl1G2OoQ3Aejr7Z+4HkDeJ1pSkI7XxGYIlrwfcI02NaDGfZqFjBVHUaEkf0knuOcpnpbP6W9TwNNJE8Xu77j0TelTema8wt20kUY6+CGx3ItKMEXoJnsCe0McAL8Kf3XX5TA6lUFYUuIXoIzQxTAAmjwtNZECU0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3493.namprd07.prod.outlook.com (10.171.252.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1282.10; Fri, 21 Jul 2017 17:35:36 +0000
Subject: Re: [PATCH] MIPS: OCTEON: Fix USB platform code breakage.
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
References: <1496250830-26716-1-git-send-email-steven.hill@cavium.com>
 <20170719094143.GS31455@jhogan-linux.le.imgtec.org>
 <d8c33b8e-e57c-f109-7747-fdddbcc7bd0e@cavium.com>
 <bce34cc9-38a2-1fce-3569-65742dc068ad@imgtec.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <a579a57a-c3b6-5702-8a16-7d75bf95e6c1@caviumnetworks.com>
Date:   Fri, 21 Jul 2017 10:35:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <bce34cc9-38a2-1fce-3569-65742dc068ad@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0072.namprd07.prod.outlook.com (10.163.126.40)
 To CY4PR07MB3493.namprd07.prod.outlook.com (10.171.252.150)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 667720b6-fd4c-4c4a-5509-08d4d05ee5ef
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(300000503095)(300135400095)(201703131423075)(201703031133081)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR07MB3493;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;3:A0tXmKmWj6/pZmP82Y99AnsgEkHE6qsX0QzsHe2g1Dk8DEqw43CEFXUIKtfYvEo2KRJsWNn9ZGfZmp7TUdg9DChtruMRi09QCSVkDMPVyNLUUwPJwwu8uvY2HIEMVCrpb0Zm0lH+Qgs1UhVGTxPx/9C4g3wEoQxoVocttIuSu7vw7m27nElg2vk4csd0ekE27Oux6WFRsT/V+0ZC++HoR0O7FlKulbf9mICbgg6Mx0W/KMUec9wUew+xrCWsixNouxe1rbozWXFBMN66fbX1gDSBqRjr3rumoLtunc30IT/y3TbmyBMihr5FLhkizkEthVA1HiXCX6VWc/ohuoBe3UsjUC0dkC8w5y1//1kXgElBIE6/FZLVr8+JW53kLq2wmZ5mD3+p6pSahQXSb8OdJ1v042/3z2dSO6sRLRnbMtY1otmLMTzkesK+bXWWPvx+UsPwmcX0aJsKd+OdXzZ5TAYNRenBVmrOZiDnPAxLfhsbrxw69HDbYyaWJ8IQAM+D9R9lyv7C6vRzgUPqXYDz6JC4EvOD5SuAS02VE1dD6G+u42SYjYUlo9D2J8nNgDyLNWD13iyI/m28Pn6vyjMX/fVq1Ah5LAY0wmlunJBeTJs4ZzJK/2+vgj3YeA6wXZwpplughwVIyB8Z3dGa8ocSy5gNfZ7CJqypPEDTcLc7apo57dWBUCGh9vCkZwFk+NaNvZQ/7MklGc8vsT3G1saoN91OuYtrSEHmU1WuDSBwNyU=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3493:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;25:60pnWt/lIwmbRQ/OyRkOoZ/4CUZktPCyACxkHFAH237ECzp6h6iWw7gLMcz0w+HoL0ByLWusxGnAAnMamE1GvELDYi5yrFHa/M+XUT0eZpnEdThnVDYLS079o9LpjDFR88L9wAixUXCmQ/SemVcUOb5cOMRCtGVUeUuW/8AIbeNkF60/SOZNy2om8BqG1vv7JgcEEARxosSl0TPuc46+Lzc6lmqyeZAE/Qm6N4Ys9UEyenpboPsNFsMl/fsDt5XdClTkE8YYtfazT/Wf9ZavPQfOu2MPbdu7Kf9KKL2z37xW+AEedU2iMTjPhIwrdqdeAhfPsM4mZZJyw+QGMB1cIHDxn5v297u+vF10V+3ng/oVWtBiT+HW+3ufpycjEKcRvIKlQADgOsy4GY9L3kS17opCZ9Wb3q0bac3ai85S2YzeLLlXLDz4JIV2BpokwJ6Zo+M/+lPBbpxsUMn1hsz9Qoc6YBtYDvs7Rd5mMzdbHDwK5Mk5u7FfQP9BNagb96p9wUJP5DbRMPLSsHssdCmRFvdY3LgCifbI3gcZUkIaYthdDl6at8qFfBJqgPoAu5Bo7Kr+jZxDaS0Q9JmCSvK0M8l71wED3hnQWsVRHpCx6MQR7mSvsgi21LH7H2fyaGeUgL98itSgAVGXvOz+q9X9XV3XR1iSl2t+r9JFr3Z/koXgTRKgbUOcZ81qV1khqyC8nX+zSShj7BEWKWgHabJOCKJ2WngQzSNzhnhjtsTa9gpntm41ygT+ZfRQOa5Ak1Mvv0QsHhkv2UmUrbHQ7z6h6SI7h+JeDdlpgLQf99CTHbzFN6Qrk7nMjwEUVcI5yE1KOsIR6u/09irTldIlI1fomkiCF26dTKSCZrCWCuMWGdm/h+3Zs2v8R2+VxzGBVVZ3YvMpoWuAWDEQPXbrCNeLeOdsFIMdXKrraQj7KF26zCs=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;31:oVsBbk6VH/HSdZhxAn9WRFz5ZaJMrYcIyIAa51nj6MpRG+T8UBKhJciuy0gPiWKaJtZntHjiHNIcnEyINIWTc+kIC2htU+UVma+nNsjO371cLbT8kTTQtafcOPHSfFobdrYFfuhUMcBeg82N/d5/ZZ9VoYAeuynFvpAgjVfqkWSHUwVVYxAX7MRM9w5xb/w6VhVJnuPm5JqComUaZZc8yVyL67auooebtTdeZJsTVYp4//Ue1D7gPN9P9PitBeJ6yWFPVHrk9CyTBgHzesgaBIBsQpvBfdCzu2m4pobNT/sUt3ZiFckB97DIrRigGdHPZEhEpNtc32s1UfAyJ5K/c6yZsr1xfzuzja2K89BINC7KQeFKAgf7Z86SfHXZe+wxCS9qcvnJb1a80BFEw/o/NKVnsR4QRBr44GqfwHweOsQJjYAu/mng99XA+yrbS/roeK2sa0bs0LdUa/Y7AstsAMq23KUtrhSnVX/ucIKnU6ZScB7VUJyPf6U1aXgV3T3BJ8Dj1bFbjwDDK+mC8zxnBSa5AN/QdvHxdxrH5sZWoVCIRfeJ76QqbIeV2nmwNMJ3NOf+G66HCc02Bcc1FBjrdnqWygk1N1QilZy0TcY8mraMgqhw28ErRBjiesOcvXN55u+6qXqwVcEFroKpyBlRFgSrD8bFi9uFD7vQ+5s4Tck=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;20:oDkcDrrfj/Ob0OGjHXp4dE+nijjT9CQHviwV5z9gU+DiyMIva/zQyLsTT6X21thr+l/ODwCddlQvauZGge97xfYzmaupPeTLfkMAv/ZcMUaEfzWj6ccFLs69ho7JxQp0fMUcLWGoL8JAjLVIVCnFh511BmqIgEfUby2W+j+iJjQgYy+eoJpTqHgF0dh3ph3/5s06O62HWtVCIxZpflZtDumDl6D52sRRUAulOK/awJbdLlOzIUdvtxMdTF2A8ExwF1JnJ2ng9iXGY7zTrITCUkVkNzZMeYBehocdq1s23ryAB0znbRwdnPO2YxHpoU8DqQTmjAIPNy07BVcp1Zzrv2qM3IwZazU3J+18jq0YveNCFkFb8F/YfTi4W0cLnMPU0mRiUP6BfMJoLm+l1sJh7RmeIz1OyeJfE/JKl7PPJxEp4T3qoHoh3PFl361J93G3EgJuoXXCJbsniFGJHt/sHWxvLENM1/DNzsT1GMLCEb3v/ANh+ip4NR28Y0oi0m/wwXh1xRMBiy0hL2XdhbMcwvg4y2wUQPDnvXHHfvVp61bNg2UfviiNH1EaEJ4eNdogN8t6Tuf228NiNb0jglYY2lmetOaZPP/p3yxOmP2J4sY=
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3493AEC66B8B3BB2042DD1D797A40@CY4PR07MB3493.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(93006095)(10201501046)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123562025)(20161123560025)(20161123558100)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3493;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3493;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDkzOzQ6R21tZzZjQ0RHUStTTUN0K2kwUDhSKzZwTUlp?=
 =?utf-8?B?OGZQYkFHcmFleXhUU3JaL3BvditycWlhTm9CQVJlQ1hPN3VPaFcxMFpWbGV0?=
 =?utf-8?B?WHYvMHVJSmJMcTlkWENvOUJGWENqaERhUlRkMnpWQ1hTNWJiQUZPWDVJeFBT?=
 =?utf-8?B?clFuSnh6VzNxUHhHRjVIOGRMd3M4eEU1d0FBYmJJeUxyWXlONFlTQmlleW1N?=
 =?utf-8?B?MkdpSUU3bFBMdmFEd0tEU0tLV010OWVtaktrbzJPS29ndmdBbjB3cUh0YTZ6?=
 =?utf-8?B?cFFZUElHRHRGSVBOWmxtOTlJbS9UQ005ZnRjMTlEZHFnL2xzYkFIOE9YK20w?=
 =?utf-8?B?eUxBQUY1MUJTSks4OUU4dG9hanl5OWc0TlV0UlN5STN4M3JmWXF5OExBd2tz?=
 =?utf-8?B?bTlEcEdZcnpicVhRc1lBdXkzNzdqcHlMZnB4UEZadDM3QnRENnRocWVBem5l?=
 =?utf-8?B?YnFVai83OFZ3UjBXaysyMG9xek5NVTRDSGZ1OG5qTnA4d3psNkJxc25uWWRZ?=
 =?utf-8?B?WkZOL09EZVZjVG5PTmFqenZoSzFZeGVnMGEzdUtoYmoxRmV0SE5EUHBBdmtn?=
 =?utf-8?B?RnJldlR0b3NjaXhmeC9OYUNyZUR4L3dOSit1a0hYa2dHem1JRUp6N3JEKzd2?=
 =?utf-8?B?SXpkYVJaOWtQcWdKWklCQnJrS3RRMXZMMFgwS3FQdUllZll3TWQ4OUhtMTZ6?=
 =?utf-8?B?b1pYdExZNTRlSmtLN3dxdkFYbFFxVTAvRFNZclpVVXRqSG4xS2Q2YU9OQ1pj?=
 =?utf-8?B?dE0xTnhOaHBmWWVFTUpDOCs2Z0xiMmphblZWZU91L2RqTDkwdkJzMEVUdm8r?=
 =?utf-8?B?bXVCcHRkWEFMaTVDSmpnd1d0Y2I0VitFMWpTWVlQclRjekI4Z3l4NXVWNHJC?=
 =?utf-8?B?dVVieXB0SGQyZEY5UDIxMllzZmtuZ012bTlBdU5WR0oySjRwbDZweWxpQWJD?=
 =?utf-8?B?WkU2WkZINFBSTDR5NExLWUZnS0hNSUp5N0pmSDRmQitJdzVSQ0pCd3FWc3h0?=
 =?utf-8?B?RDhvTHRQbnJSTXZ3anhEeWJSc2dJbEV4Z3VDa1BLU0Z0RFk3Nlh1dTRRMEx0?=
 =?utf-8?B?NG5LbzNKZXg5N24vNkkvQlBhdzh5NFFPS2htM3p6dmRqdEtMVUIveW41a25F?=
 =?utf-8?B?Z1V5MDg3N1BTMTNEZGY4SkJFdlVVcEtIbVRFcVRzWnJ0YXpEdnBkVi8va3Rq?=
 =?utf-8?B?YVA3YW8xMHVuTExPdjhFR0FwQ0VjTCt5NjBvTXExYXZtbTNreVg3Mk9nbGNj?=
 =?utf-8?B?THJ0dmRmRGdOalB4R0VFQnRsc2VvWTFCYS9YMnBDbzRoa2hXa0xFZGM0b3VB?=
 =?utf-8?B?TW5NbTQxV3JaenpkV1hCVHVvTEp4RHJ3cWtEcU5BdGRDb3F4NHBXWHJhcnN5?=
 =?utf-8?B?bHBkeDczdTBab1YxZldyQ1BFTnBXNGR0aDBJRlFaMlRTZzducC9hcFo3a0cr?=
 =?utf-8?B?SFdyd0c2aWo5VmxXNE5RM0ZNU2F3Z0VTemxmUW1ocVFQQkNnUkhFeFRCRWlO?=
 =?utf-8?Q?JgmOm+V1WTK+BhupQqbEZVYM=3D?=
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(7370300001)(6009001)(39450400003)(39840400002)(39860400002)(39410400002)(39850400002)(39400400002)(189002)(377454003)(24454002)(199003)(25786009)(50986999)(101416001)(229853002)(36756003)(6506006)(4326008)(6486002)(76176999)(54356999)(72206003)(65826007)(33646002)(5660300001)(42186005)(93886004)(53416004)(105586002)(106356001)(50466002)(3846002)(6116002)(31686004)(64126003)(4001350100001)(47776003)(69596002)(97736004)(65956001)(81166006)(66066001)(81156014)(65806001)(2950100002)(7736002)(305945005)(6666003)(42882006)(189998001)(8676002)(23676002)(6512007)(83506001)(2906002)(2870700001)(31696002)(68736007)(7350300001)(478600001)(53936002)(38730400002)(53546010)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3493;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDkzOzIzOnd6c2NOWGtyQUdRVEt3TFNWMG83QVpVWXdH?=
 =?utf-8?B?OVBkMjhRclEyNk43RUg1Rm10UEpvUEtWVVVZVHpmVjkzaGF1aHllaTEzMCtz?=
 =?utf-8?B?MHdFOEF3UVFBei8vcnpjbUY2b0FrditsSERPSnV6ZlpmL2huSC9XTSs3T21R?=
 =?utf-8?B?eVBLNGhOVWM2aDBWRVpRWE5hMjloUVhNVHN2U3lvbFk0WC9FN01GZWtVZ2Za?=
 =?utf-8?B?azF3WFRVMXArbWhFNkIwQ09SOUtqeXM3UDhGS3llRXU5RzJXL3dZZ2p1Z2pm?=
 =?utf-8?B?TUp3dFNzV1Q1WFRoUkJHL0Q4eWZQWkxxRUFoQnFFMENaTUtvRFZIRHFYdFZy?=
 =?utf-8?B?UGFmVDlNejVDZWFjaytBZ3dPVlp2SDg0bDF0dFFtbndzNkFTYzFXbDlrWU9B?=
 =?utf-8?B?MnRrc3VLTThxMGMvWjVCQVptNmtzZDJoMDAwcGFaUnZ0NFNOZXZtMThFOGwx?=
 =?utf-8?B?WU43cFdVZ05jZHZlZXZ1NHo0c1hMMGxSOWpab2xCRzRqc0hIUUdsczBFR3ZO?=
 =?utf-8?B?ZnhYbW9IL2Z0U1A5c292bFBJNFM0SjVPa3oxZ0RxM3pFT0ZOMC95MDlIeHc4?=
 =?utf-8?B?WHhIS3FVVmxEV0QxdSs1ZzJNbmpZLzVNU1BxWURUVjMwRURMY1lNaDc0d3Zx?=
 =?utf-8?B?UGtxSGpJdHVNSzEvQVY4bi9OL1RwVnNwK0VESlpTSmVjZ09kaytUdm1jQkdC?=
 =?utf-8?B?Q3lmU2RlTm9iWTA0QW5pTStYRGhZRU9aUVdtQUtaNlZWMDI0Y042Lzl5aUVy?=
 =?utf-8?B?cTNiVWl2dHErOS9PZnlCR21hUFZuMFE1MTRMNG5VVTQ2MjJ2NWJrTmZ6U0gx?=
 =?utf-8?B?ckR2TUVURFhMZ21hbVVZRnhST3VrM0ZYOEUwRGR3Nlp4N05PZllKN01qK0FS?=
 =?utf-8?B?N0ltWjcyM0hrUGpKQUFVc3FiVlZLYTAwUVBabmNYb2dLM0YwcnlCRnV1ZFdZ?=
 =?utf-8?B?ekFzMW9NU0tQUXphUDN0aERNZXNTWlViVmpRVWg1U0hOMmFtNzdHQzd2U28x?=
 =?utf-8?B?VzBKeWEwYndNendLWUU2MEtzWDJZUXc5SVFrdU1HbVlBNWNQaGhpVzNjYmtQ?=
 =?utf-8?B?bzZlQzRrenVWa0VzdlpMQU00OTRJNWYyQkRUZkpSV3BhSVRwRUxlWGdjV3Fp?=
 =?utf-8?B?TXJmc1hBdDFtZUdWWkR1NFBZTS9mc3ZKSGpJYkNmb2tGekxYMFhoRkRjRG5h?=
 =?utf-8?B?RFNuT2dQWStZTGNaQ2srenF5T1ZyUTBvQ05Jby9VcEUvVVFaWUlJdFNlUVVQ?=
 =?utf-8?B?cmZYTGlkQ1ZqTElsTXRaZmJxZ1FzWGw4Wk9uTFBzYWdNVnA1bnZJL05FbHlR?=
 =?utf-8?B?dnYxcDBmaFRNL0Y3KzVsYWI1eVhMNC9TN0VDdTRTZ1VERzBqLzVZVUwvQWFX?=
 =?utf-8?B?K09HVDk0bE1scFZlY3MrTHdrUlN3Mk03dTErMmIxZ0lINmlGOUhkRWY5UGxr?=
 =?utf-8?B?TWtjQ2xDQTdpUWkyYklYeWV1RkNkUm5OajFZOGFaMElDOS9pYldvOWFVS2N6?=
 =?utf-8?B?K2hmT0JlMVRHVE1ZcThkaGNaRTJYYmZDZ3d4Kzk5VW12eW05QkNaK0YvL2NE?=
 =?utf-8?B?cHVCdnJPM1hEV1QvUEZNWC9TUzNmbFlYL1g0OFNRT2NKWmwvSDZtV0ZCRFBB?=
 =?utf-8?B?QzBKRUtjRlZOSTM4K3pRYytYUkdSNTlzYjdxZkY3MG5STE9YMlBrbk1rV1NB?=
 =?utf-8?B?U20yamJkVno4OW9QaFRBSEhtaXJMMGUzcDVwRjdPQU1zTkFVVnk1cEhTNUI5?=
 =?utf-8?B?MzU1RjBucGxVM0xmNWhaUThJekRXYmRYekp3TWZtMmFLMG1UaVY2SG1hbkF4?=
 =?utf-8?B?YnJVem9pM080azBQN01MYmVjU0RuMElpNDRyZzFOSitXK2F1elVDallIc0hT?=
 =?utf-8?B?YXdZaWVCd2U0bzZDWDJKcnQ3OHo5RnA4MFJTWm91K1F0Q25Ud0dsbXRoVDNr?=
 =?utf-8?B?ZEp6SUR5STYzYTBKcXpraUpXVWtpZ1ZEM1p4d2NEUjdxOUV2SFdzVWFBM25n?=
 =?utf-8?B?ZW91SFM1OWFaUmYyOGovajE0YmJKK043S3dnZmd6QjFpcWp6SGJGMTFlN0I2?=
 =?utf-8?B?NzArV3NZZmk2bGRqSmhqVG42bzM3MzJWZFhhNUNMZThHNWtBZXQ1alBnNWg3?=
 =?utf-8?Q?0sW9zcp49MSMbLp53xN9vBVWARplBkLMZN/aswhG9PFu?=
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDkzOzY6WFlMRGc1a3dSbmVKM2o3a3dmSWdEVStIeFZi?=
 =?utf-8?B?b1N5VHlDT21ON29WZ2tsbytsT25uTzRRU2psYWsxQ05tTkFHV2d3OXFGa0hy?=
 =?utf-8?B?TEswaDBwNmZTbHFFa3U0bExQQURjTStiUEFybmcxcDZFM2h6TnVZNVF0elhG?=
 =?utf-8?B?eWJhanNuUlNmcXdwblh4ZDdiODA1S29oNmh1NzZSNmJhR0haTlJPcCtYZVRS?=
 =?utf-8?B?NWNNZGFLdDk4eFZyc01MbGRld2J1S2dUbmZMS0c1bDJHNVFlaUxzRVdVRE1t?=
 =?utf-8?B?d1VmZjI1Ri9hVndCNkxpd2JZcExWM2NaQTVHc3RBU2d1a2QxeXNjZE5ySzlT?=
 =?utf-8?B?ZUtCdndBME14WVdwcjh3eXQ2T1hqOTdSSXhyWjk3YTZEV1ZNSTN4MTV1eE0y?=
 =?utf-8?B?SjNEWVhwZ0VMMFNnV2RBVkZxZHdvcC95OE9WS3VGK0p5OWRhY01PZGVVZy9X?=
 =?utf-8?B?RkpQemUzY1JXc1M2S29ZYU4wQkg3MHZsVHI5L3FHWWgreXFTc1orNmZlU0JF?=
 =?utf-8?B?YWpUNHhkMVNLcHVpeHlSQUdzNWovK2Q5RTlHL2dJYUEvaXVBQkxaZGdBblkx?=
 =?utf-8?B?K3VMeVhjWXdtSWZvcWJtNE1IV2V5T3ZTUTlvcFRIU3RpSnVjVi9QYUJtYnJT?=
 =?utf-8?B?MFNraWVMUWNOU1pxanROV2lKWWNmcmR5c1hUTC9LMXg0OTNMU3duaTFncjll?=
 =?utf-8?B?cVl0Q0lsRmJCc2FuZ3ppeTVJWmRwaUdQYzhoZ2VQb2YxTXlKOW9VSkNFb0xD?=
 =?utf-8?B?RHdrTjJzNmw1eFVBNDUzYWlNN0lJbTJ3MksxcnFNNzhiMWFEUll0TEhub3F5?=
 =?utf-8?B?T3JsWVd3TEl1d3MvTURaL1BZK3VuNmx4aWlYdUxZQWVIRmxHTjhnN3gyNzhp?=
 =?utf-8?B?TG5YZUtzejVCNWQ2MGMwOVBaMllyZmNzdFNhdklScFI5T0Q0MUhnL1pUVURH?=
 =?utf-8?B?T2MwSWlTVUx1TWN6ZmljNzBMTS8wdUd3SzFoTU16NitLZEhFVG13amY0YkVL?=
 =?utf-8?B?bzc5aEV6UDdGRkJtKzBIdlg0QzRKaDFBVUJmNnNrbGs3N2g5Nm55OEpxVml2?=
 =?utf-8?B?eTZqNnFCZys0dHVXbzZuamwzQzkrblhjbS8zNVhpZDl5T1B1blV1Si9ZMURo?=
 =?utf-8?B?VE1qUUt3NDE4SjFWbTBBZFcxajV0YWJteDIyRnZneDNoMEg1M1J5N1Q5ZUlu?=
 =?utf-8?B?ejMwN01TMElVT0NobUhqVy85MHJGYjJOSE15UVUzdVA1NmRqcG5LNGx4NWRm?=
 =?utf-8?B?NzE2cFRETTZ6ZVRDR050OUZ4ZlRnaWQ4dGt1dEEwa0RlaUJ2TFNkMWxFcjY1?=
 =?utf-8?Q?0GlyonNDv2hbcrD5uWpTfJsydi5bse4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;5:4Qi9YusNkOR+7RkyjwocRZYswb9ixQhLpQ9wgDrremXZ8TJbjtS+eLElX/YvumJaeJ0PeLzmofLW8RhaimQsbg1/B48jlDvFBd8lnnz8JlDWfhinOdOUtELcOquDOZimo35dC6OajYZ1YV2nyv/r62S7trVfmqShlttjo4Ue5e2pWXXVtU/By8BwJ2qob5znzf60xhotDVkVa3GTU5Osurbyc9PGsHotSCCvtZLRpSv71Ova6DvW7x6LsYG2cUsmgIwlAyEansk3afYh64o9h5kO9oNb2Ka05QwZ453F8rZk9STHJ60KzXTZclNf+iwp+RtpS8vyIxwapDNmQHH6lJ/imkrrj3kp3zgPK2lJPJ02uSOaxfgMrMNjDtuH45lw3/VcGzRWMwJQ7YF58X2g+bE3ldNZyzhxLqJeirS59Wd/AgIDpcg63EnllHjf2GEi/enKhqLk6n29vrqxbGyFWHwQFUJZ0oMq8NZAZ8JTF3SHmVk9ttW1M/1Q/XUjj/Vn;24:Xg0Yzqfg2LN9LFH2vM8/gUlCrEdm+78cQcjz46gAYv2hKWAHhJFkK82zOGEaIhQ1aytnOPxG0fTNSnPCLcqVsgQh/00B6yXxD11y57TSdUc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;7:D8TGtOyrc6Ua0DxVtF2quNPZStQ8eoukUHBR5GRjE5iUn+dSGe3+svd3feXzITUoedC5RwOsz3bEc5rCn+rnYUuyqKOpHqdyCy1oC6QxbIU0NT1zPGIRiTIJngJnYoA64Nf4vUpj+y4ercOtyzRiySRZvrAmt7U/ddhjOEAFXmr0rxPb7kKupXRJSnthbfY4iQHYI7d/VZD9QJxCtQdfZRG0lOqiyHIIbk1eHifE0CMnaS5buMDU74e5cheyAGStjfuWSswx/ykS/cg2PF3ABvIdM/tRU1hOa6o8kHy0Hsa2flQUVzeZZfnrYWufFLI8yso33rgxT+hA8/mAYAbC5NMNdzZXVDpZQpGnKZzo8wywkoHrFyq0+tXsl+V6ORmEtMgeFBYWX6sPoVCgzpiOGJorhH+LW9w/abMCDcVPhFo3zEhZLbEpf+EiwdheVPGj6nnogcUtFg6ALcmf5JV2DEPnLfRsPKN5btJAy6XOzK8LKRcNW8cOXJvo87gUaA7exLMwSjzVxgaHlF7fyk17yG9LtPukvKhLz63PXExYzckU1ysBVTTyE5Ojageu/oTcy8EMaqsssimqQf7PVwTa5jj6ZHwPGfNBgqNxnGOZIhR+riMVfe55d2Xs13M4M4ONiOLYZ5iAEYNU+52GnuwR6VnjuvBZWVontueHn4EZHeRkcNFyOEc6lmvb0sU+E9Avszm+aqiSAu1y68vFyAGMGJMje4FV3qWCL0iGID4CdljCIVGgIxm8MkYYc1o8c0mPPSYId1Pu8gLqt7YRFgTqDwCENJqrAUgczMIX1KNlihU=
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2017 17:35:36.3628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3493
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59210
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

On 07/21/2017 09:10 AM, Matt Redfearn wrote:
> Hi Steven
> 
> 
> On 19/07/17 16:31, Steven J. Hill wrote:
>> On 07/19/2017 04:41 AM, James Hogan wrote:
>>> Is this already fixed in some other way or is it some unusual 
>>> configuration? I couldn't reproduce any failure on 4.12 and you 
>>> haven't quoted the build error or explained what was missing that 
>>> required io.h to be included.
>>>
>> It appears things are working fine in 4.12, so I have dropped
>> this patch.
>>
> 
> This is indeed still broken in v4.13-rc1 with some configurations:
> 
>    CC      arch/mips/cavium-octeon/octeon-usb.o
> arch/mips/cavium-octeon/octeon-usb.c: In function 
> ‘dwc3_octeon_device_init’:
> arch/mips/cavium-octeon/octeon-usb.c:540:4: error: implicit declaration 
> of function ‘devm_iounmap’ [-Werror=implicit-function-declaration]
>      devm_iounmap(&pdev->dev, base);
>      ^
> cc1: some warnings being treated as errors
> scripts/Makefile.build:302: recipe for target 
> 'arch/mips/cavium-octeon/octeon-usb.o' failed
> 

Steven:  Please figure out what config causes this to break and see if 
the patch fixes it.

One other question I have is:  Is devm_release_mem_region() really the 
inverse of platform_get_resource()?

David.




> Thanks,
> Matt
> 
