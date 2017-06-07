Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 00:47:30 +0200 (CEST)
Received: from mail-sn1nam02on0068.outbound.protection.outlook.com ([104.47.36.68]:62861
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990508AbdFGWrWXGNCm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jun 2017 00:47:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=o4/FD4h4/XhAokJ7ZHA2u1LOZt2hvPTc2XbDUiIVoE0=;
 b=AyNYyQ3XCH48WPKh5hdlCAzjfb8nI1X3myCstQVZyYZA24e5H5b0K8SaXtb2q4ZiYgOvN8CFxF1KuQgDeDFk/QH03rmtWni3ppKCuRPPXPXCmoiNMTVD+3MVwPIwaS7aK2z317LyfR67B4hgovYSV40d1QInHY5OIChLQRRz5Uo=
Authentication-Results: openwrt.org; dkim=none (message not signed)
 header.d=none;openwrt.org; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3493.namprd07.prod.outlook.com (10.171.252.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1143.10; Wed, 7 Jun 2017 22:47:14 +0000
Subject: Re: [PATCH] MIPS: fix boot with DT passed via UHI
To:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Jonas Gorski <jogo@openwrt.org>
References: <1496776596-5045-1-git-send-email-andrea.merello@gmail.com>
 <fd8ad5f4-ab71-e8fc-a7ee-5177877cfb74@gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <2d887f2f-b83b-3540-37dd-182aeed1fc0e@caviumnetworks.com>
Date:   Wed, 7 Jun 2017 15:47:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <fd8ad5f4-ab71-e8fc-a7ee-5177877cfb74@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: MWHPR07CA0042.namprd07.prod.outlook.com (10.169.230.28) To
 CY4PR07MB3493.namprd07.prod.outlook.com (10.171.252.150)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR07MB3493:
X-MS-Office365-Filtering-Correlation-Id: da36a2e0-e3d7-4e0f-010e-08d4adf724d5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3493;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;3:vcRwVuK6lvwrnGbdehQghDba6pYw+yrpoo1q9RMjd/HbwjI9x97xf/uT3PZU+3lDhmjO5N6T7VhZI8nO5I35mg73pto/Yb7/Ae+dBu4zD/0ppiTVIEJaU3BxD//BzaF9oOpoC09JWehu7TBtzazFzsIKxM/BlMevZxlRhfDgcKA/8f4bVFHSU2WMf6A0xCYu0y69JvAbm+EzdagL0V7UoZKUNCHHttX3RJ4NTPaN/FORIOrZX+6uqiMfR6nTaZlpLxTkS2dBjq7IRdqfKAu/Mp3SquKntJt6jM/LikZl0GwnU2Kz7mKZLBF0jjJSyIphoUGtOaNGfPLWuTXkFxj1/g==;25:yRGuYNtmu1qVa7TrylpViukFonzqYt3PSGTPEE6D8u+rVql5oHpgxCjmXqs3sHWIJTd9d08isfipj4SHYIcfrp7kJkFi1h+iBblD0O+LUxlWum46LL98DsXByxbxdJng1XAJHNtF4er9cVcJKNtqTo9mDE55i4Odp/fyjoIqRUEk1Ymm1MK/qmJrQGegbEsYse/gqfFCvqZPjYJsSILRh3PDHZ8Kvys9MkOGoFgR60cM17PVvbwA9F1bxzA4ZLPxCql15/+c3BZRzB/+pweq/c3Hk1WMimzH02cmRnHEu/iAsTLvCbdiuzi/7Y88jVF4sh/NkDP7RVN/nKO3Y6hIinkC24xNkmqr9B+MftoYCoOzKG3QWnoIk10XcYHS2Wk5Tc0oUQ6WT1sqr/skjoIG+qwtAKVnwSZ3GLKtHhwAdCmKP3H5khk5QZVtaRqgsWwPS9ouSzdVGQ2J7JvJB7UBvbREvACNmJDDQzBxnqpv6Dc=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;31:MLLChqP03p5lxxj5M16Bqf69y2P/g0q4QmjvsuwhZ+h4wb8RD9Jua4rVJ2TKwS6aBGUw6HQikXopZiDMTV4cOpTQooA1ZJMb3IYC6l2BL33Y7YSdd+kwlVqmfh+HUO2uYMFeaxDF2U5mJoDzYwV2RGfKkhlpc5mwhiX1YQp0aGFeSQtWZ25OZbPbU63Bw4b9S7j8CqA6mov/4bWTyh7CvVD0c0D0bGzw9nYVk3/YQ6Tr+/fumejbQynGkdz0MDByUGbzt8zPCWEsB9u0887AIg==;20:Fu5DLXOpemSwoStllFbcDSsqWlyoyjK2K2Fk5f+QyiD2GWpJogi6Dz072LMK3AtosaR8LX9dPmvnKKicc7pegIvuOnEUiY7a1JZkklRzanOMLunTv8kjhbMqv4P20zLxz/1WZ9SytBFDls1lIDXBSoYv8jKKfOX9AFATHLW3/zIoT+rSESTc/iDnBHGzHFTqITzTTM8F0kfNmKl/iL5uefvYKUc5/FUDd68UsQdObEQpqPYofwtha+URJrCyIRi5XiSKDB6jiACEfV8xTXgf6EzzI0/p+kLbBAzF1vlrSnqwhIghwClCwPJKn14P4wnJUi2AIOjt8UGxmbC5ckInl+lndiYJt3sS97w7VyHj7STfVyBb1XZthBptR3Ff+6dUl+uh5jta4sd6xMWyyzreSwQQe0jDGVJj3gViEnl2lO0nABodpIWOP6vmgaVJWaZlRy0Wg0Oq96mgQly39KKwLpIeaJ68ugI3F2rZfRdiypZNBYWzi9kE/+1VQ6rW6Mz+Tyf34djESZPUYFNosxficgYQl8BjbwfflqFhI9WXcHWJ7H/592n3m9zVT7XmASN0L4ymoEQ/urU96ajfaULN93xYM5pFAaEBGU00W8l6Mj0=
X-Microsoft-Antispam-PRVS: <CY4PR07MB34939E3D6431186B0E4F86E197C80@CY4PR07MB3493.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(93006095)(10201501046)(3002001)(6041248)(20161123555025)(20161123562025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3493;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3493;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDkzOzQ6dHFIVEl3UkFlY1l3U21Tdm0zWEhpSWY3Zmg0?=
 =?utf-8?B?WDZHNnZJQWhubWZ3RWF2TFJ4QjVFMlpxQ0FwU0RJclpwL1V2Vy9uNHprdGxR?=
 =?utf-8?B?d2svU2FSUm1yeGI4dzd1aEt4a0hpK1BISGhENi9BQ0ppWWkrUlR6bHBuSzFa?=
 =?utf-8?B?TC9QQlRNUS9uNVErcjl3RDJmenFZRFBwMWo2cWQrOG9kajJjUFZjaTZWZlVx?=
 =?utf-8?B?NE5uTzY1eGVMb2JrSGpKYStlL1ZWbUd2RkVycGFSdlVwR0FLeU9JblI0b2E0?=
 =?utf-8?B?MGhyMUh2eWY4Z1FPdkZCcEFDZStJUDFudTNEYTVaN3FPZ1FOVGpZdWFwSnB4?=
 =?utf-8?B?MmVCbEJVdG85UWVhcWx2U2VvV290YVg1V1V6VmhMdDJXUU1kV3VqNi9xL1Bi?=
 =?utf-8?B?Q2dTWFlWVG1BcGJIREQyOHJLVmNPQ29yVHd3RlNLcEw2V2JINVdEU1hyY0d4?=
 =?utf-8?B?YXl2bWNra3FaalRvdGNBcDkrajNzeGFOZVIyaVdrZ056VzgwajRuV0pYa2N0?=
 =?utf-8?B?eXBtZlg5OUNmbElkQURZVDh4QmdiTS9EZUlZalcrZUFSU0dLdE9DVVZaOFcx?=
 =?utf-8?B?R3JVTm5KdDE0TCsrVUFpcnFPclVCaDNXd0N4a1RKRlFuK0RReDdYWm96bkll?=
 =?utf-8?B?dEgwaWFrM1RtR1lCYk9iTWlsL3hpeS9PYk5Qc0hneWhSTThCa0I3NGlCcm9r?=
 =?utf-8?B?SGJzNmhtUnZ1RUdqQTA5bDErK3owOEdvSmRGb0JaVE82clJzTjBEMGFlS2xL?=
 =?utf-8?B?RGluZEF0Wm0yemd3SSt0L0FhT2xGajY1cFgySUhlTDBaajhCa242N1Roa1Vs?=
 =?utf-8?B?bVpJYTBENUhPd0VoTGo2ZklCdTJBOFlPL05QVG4vTGVySG1Kdzl6T2N1RFNa?=
 =?utf-8?B?eGx0NVYyUWwwWE9rV21LbVZsOU4yMmdVVmZKS1NFQk9QSmM4UmFwVllVZ0ls?=
 =?utf-8?B?TTgxdTh4WG1nbitlVGw1S1dYWGd6elZyeUJEZVFRREdnRWE0T3hCcnZRcHdo?=
 =?utf-8?B?Ulh3SUR2QkgyMEdEeGwzMVo4QjRCUW9EM0JOUHhZelJhSUlCNUF2dGp6K0hL?=
 =?utf-8?B?M2Z1bEk0L01Oa3dEMWUySGNlVkhqUHArY1lYYktrRHNrSStaeHNrV0p4VXRS?=
 =?utf-8?B?SWllVWliM1k5T3lYdUdhcGYxaGNZekRSUDVTQ0IvRVh6Tkx4Q0RVSTAwVlU3?=
 =?utf-8?B?dnVTVnN1Wm1JMjRYeTdXak1INmhKWnoxQU9qVnFlaTFPVGt4RmZZbC9sODlt?=
 =?utf-8?B?OXhGZmtPUFgvZ0NHVmZEc3daN3FmVUxkRElmQU1ieW9zOGZ5a0k3M1pwMURp?=
 =?utf-8?B?TkwzTEROWjZSTnRoWlk3amZZSzhObGgxYW9QRTM3U3Rqb2l2akFETFpwMmlD?=
 =?utf-8?B?aENaOFZnRWJSb2RlcnhQZmh5WGdQSzdoMi9FV1hXaXRKeWxJZXQxakc1RU85?=
 =?utf-8?B?Y0JldWgxTlkrb0VRelg5aE5GL3FGQm9KT2pwYzJlQ3hxK1NoMFllNWZDaCtV?=
 =?utf-8?B?enRrcnlaTzdlbTQrY0ZmaW10NkwycklvVjhNeFJFcElJN2ZJRUs5MTc5UFNl?=
 =?utf-8?B?a2JHV2p3VXJORGJzOUpXUDdhSVVEZz09?=
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39410400002)(39400400002)(39450400003)(39850400002)(39840400002)(377454003)(24454002)(6512007)(42186005)(72206003)(53416004)(478600001)(6246003)(83506001)(2950100002)(6506006)(38730400002)(31686004)(53936002)(66066001)(33646002)(50986999)(76176999)(64126003)(47776003)(2906002)(50466002)(31696002)(54356999)(23676002)(6486002)(3846002)(36756003)(4326008)(305945005)(6666003)(7736002)(6116002)(4001350100001)(189998001)(230700001)(53546009)(8676002)(229853002)(81166006)(25786009)(5660300001)(65826007)(42882006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3493;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDkzOzIzOjFtL2NtdWdCOEtMNjRGZGVCQXdtZnBidC9l?=
 =?utf-8?B?Q0l1QXpCd2tWUlJZTElnZjgxdGs1TXVvYUJBYzREdmVubTAvR05CRmIzVktX?=
 =?utf-8?B?VWpGYXpNZ3I2YzJPMXpXN29kRjBzLzRseVg4RTJncEFvekRaQUV1TGZQVkFE?=
 =?utf-8?B?TjFFbE9hL0FHYW9WSXpPUkIvYllHK1psNFpGUXVZOEJNVTBXQWIwRDlJTHJV?=
 =?utf-8?B?SittK0ZSRGhFRG1Za1VBeFlpaGIvQnlqTjEwMTQ5TEpmeUUzL1FxM21Lb2NB?=
 =?utf-8?B?SGN5TVNkajhrT2ltcGtWWkdJREhoQzFJcEpUZjhNU3MwdUxvVjZwai9TZk5X?=
 =?utf-8?B?NGE2UnV1UFVBSm9LT0tJTU5pVkN3QzJkTUxITTZFNXVkOGNzaDBNd1czRDNK?=
 =?utf-8?B?Y29xb21FK0J3Z3JRZTVqTGFCUjRITVhOb3FQS3pOSnh2RGpuVDJpNW5WbDR5?=
 =?utf-8?B?TEtKRDVwNUZvNmJWclo5QVV1ZS9xamVnUThRU1E4NHdFV2ZrTDdpOFJFNTVw?=
 =?utf-8?B?Mm1BTHB1aEMyRFRIbCtvbFNPSHpHdnVHSFB6UHFtNC9FVEowN2xRSVd6b21u?=
 =?utf-8?B?Y2UwMlFVK0tXc3hYZEoySDVSN2dTSHpCRWNVMHNUYVkxNWlHTittSlhPb2Mz?=
 =?utf-8?B?QmdQTEdwSnBTQno5UUlVUnpSQkU3cWNxR2tIUDhYS3NHNVpXRnhTL01oQ1ND?=
 =?utf-8?B?SnZhNDk1S2pMTSthc0F4dVZsWC9haE1TWm45ajg5S1VTb3ZHTFBUZ0Y2NTdJ?=
 =?utf-8?B?NVNEUjBNOHlpUk1jZGprWE5oZFRncXRLUE0yUnpiOCtxWG91VEpTdE1qUVZk?=
 =?utf-8?B?SXpDUEVhOVNxcEpQNktzVlJHd2t3QmhCSWVtSTAySGRLeWpBMU1MT1dDSU9I?=
 =?utf-8?B?NkJBMzAvSWdSTGNLdXptZzhjTXpDejZJUFBtRkFTSktQb0JmYTdTV3paalVR?=
 =?utf-8?B?VHpvSlVkNEdEeHNGZjFQWmZGSG5ySnB2ajlwV1ZoVEpsZHp2anpFY2JwYmNa?=
 =?utf-8?B?a00vRWd6VVBGdm1OSVhBTEIza0NXV0xJQ2JUNnJuMzJadWRCeVd6ZXc0WWt4?=
 =?utf-8?B?dEFLcmVjdHEyVG1LVmtLeUlBL3pvWmE1NStySzZiTmlEb21BQnFVSi9MaFg4?=
 =?utf-8?B?TDRERGFpUk5XeS8rUGRYeXhmZjM0NWRrZnFtand2UHRYZm82a3BBeDg5clR5?=
 =?utf-8?B?T1gxZEdXTk1pRWJlYmJNbnZxRzdUbnJRTzY5ck5JT3lDYUNmRGI5R0FPdHdY?=
 =?utf-8?B?aEdKRi9VS0VZazFtRUo1empGc1V4Sm5mb1FHSGhuQktGRXhnckNFSmZIODhr?=
 =?utf-8?B?ZGV2cUtrcXdlbzh2NGFXOGU4YW1Vbk14V0Z1S09BOUJyV1RxTVd3ejAzUXV5?=
 =?utf-8?B?TGVib0o0WEFSSkEvZEpoK1hONUxEeHhmc1RQUkRYTnRxY1p0MjlneWd1YjJH?=
 =?utf-8?B?TDlmWi9VQnlqV1hqTXVYZ3NyVHIwTkJ4eHgyUi92bjZ1Vnk5dmhSZHNDTFQ3?=
 =?utf-8?B?MHphMkxTa2grZTRndFFESUNFUXRlWTJrbUxtUStPTnVjOVZ0M0xWMUlVSU9U?=
 =?utf-8?B?RjNhdVJTY3R1VzZWakJydFRkc2R3YkkreUo0VXJtaC92UXRiRk14WmRNYTRi?=
 =?utf-8?B?V2w0OHV1K3ZVZnl5RXZjalhEMnRQc1pUbzd0cGNBSjlycjhkOGRoeTluMVF3?=
 =?utf-8?Q?PB3NCOPJ7PKyDDVzT3081vLmMSjtPwVRPHcmeOn?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;6:w1RlKkG0t1dN37dQfOskUzdCpI7rerye5FGeIAlxjS+3GItHt4voFSgfrCPUgie/IaTp1thqOsNuk4V/lA+t/4PrhjaoxAR68LpYgJhOBJgUNOwZf528qEbe8Gwt6N7DWPUN7jgW27Ci0cpBvqHSoyIvfLbxaHzdLeWQQG9S146TTKPDQhFz1Wthu927cgCNgiFfiSyn/pmHcYTN8IP61MiWyHdGk2VqEtFMR0BMEhUbn3iaxRU0Z8yBkbG1XX3tjCPOurA3VqlO17AkqXnIx5STsZ1RKJWAAelN2sHpeKD0yka+94AiB/G7zF3n9s4NLBYEePyFwqpZuuThmTIo8D4UyBvbxnzx0cxRBVEAY20eGXtHTn+Yfoiw+qvbAFrfZw1+uNKYcKEv124XSBTwizNofzpIMqavfZeaCDgp4DgGNifUrmkRqS8rZ4hR2NWNyx1YUPzLq/TWYR0TGGStRod2hEaxTxXThsKOWfM6/8F6xO5i75XCKDLo1hopVdC4X9qfWi0qfMFtTJIjcE9Z/w==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;5:5AOhmrVkeP85+CAJ5kExEccEK531/zTLMg7dkvHlgKuEHVYzLGJA1exnO9XyLfI1ObjvQt7qdaxvFShh6ZyBgjZPJU9p3+hZIb+0uaotSaqzu7EZrydzLtxtB6HrH8EfmTVGMfhlQuYRhkxSTPZx6hwyObKuc3+qXsIhXDCFG4a+z7aguKg2uBfg4A4lfiXEOcn4HKmfkUac+nzo0lhXw6ue84MN8tVU6/+8aKEEd/RcaBd9RgQeHbnZl0oz1S/qPQQJ+bk9bEHWLSz/ZQ63LLDFhQ6GraKJRbJhem6UmNBuo4xeTJqewz8fzMRiDHNNGGZbHDp5bdDIPmAMbk+xEkj7CuSr0Lvto2hW7DhZzqWRhfMxNXkUdrQ3FBHjFhfEs4ktqn+7Vr1+7MumxTnkewfRrAM/MZeTPM5eB9G+JbkmEErV4Pk1kovSFua9IqMjNnl52ASp5BA8noHqIG1anY4qlUvjbov15DfnwOt8RdfnDiJcgH28JWRACaeiPkpA;24:uoS07LZqwL7rEf3x+4nCYDA64yuDMxR0UleoL34+XnspNtafP34VBR08P9pghFnsPi5VF7wKqu2PUbFz1Kb4h/lxTujmOby40x31VF+uZdw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3493;7:KnaCDjxC6E0Wolz9AJbP5dO2ui2cvQi3ToTKt/3mntXPrfIA/0k36W+X4dNIjQhSFPCpv1bbZ7hNAVaH4DiGnOZ0Rl4NXOO9xvYlkYNhYXaTHlU03RBjLUJqbDlC9NofZfJYPOke0cU64KowIDVX+05zCaKDdodaARId3HbIqa/zhnoLxekll74sWOcOveq6czR+4PKABmsd5ztzWCJLDukCSie19I14zQMDgzPw2NUh3Gc0H6sOGcyM3wR3RfXEUqbDmABsOik4KpWEccclaoemgcMxhrKVdBvZoQepa3nzVdqupbdEU6Fv4lt+nZ/Q4mTcm9oTPaAiazjM/Bo7Vg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2017 22:47:14.8456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3493
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58292
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

On 06/07/2017 06:16 AM, Daniel Schwierzeck wrote:
> 
> 
> Am 06.06.2017 um 21:16 schrieb Andrea Merello:
>> commit 15f37e158892 ("MIPS: store the appended dtb address in a variable")
>> seems to have introduced code that relies on delay slots after branch,
>> however it seems that, since no directive ".set noreorder" is present, the
>> AS already fills delay slots with NOPs.
>>
>> This caused failure in assigning proper DT blob address to fw_passed_dtb
>> variable, causing failure when booting passing DT via UHI; this has been
>> seen on a Lantiq VR9 SoC (Fritzbox 3370) and u-boot as bootloader.
>>
>> [    0.000000] Linux version 4.12.0-fritz+ (andrea@horizon) (gcc version 4.9.0 (GCC) ) #29 SMP Tue Jun 6 20:49:59 CEST 2017
>> [    0.000000] SoC: xRX200 rev 1.2
>> [    0.000000] bootconsole [early0] enabled
>> [    0.000000] CPU0 revision is: 00019556 (MIPS 34Kc)
>> [    0.000000] Determined physical RAM map:
>> [    0.000000]  memory: 00696000 @ 00002000 (usable)
>> [    0.000000]  memory: 00038000 @ 00698000 (usable after init)
>> [    0.000000] Wasting 64 bytes for tracking 2 unused pages
>> [    0.000000] Kernel panic - not syncing: No memory area to place a bootmap bitmap
>> [    0.000000] Rebooting in 1 seconds..
>> [    0.000000] Reboot failed -- System halted
>>
>> This patch moves the instruction meant to be placed in the delay slot
>> before the preceding BEQ instruction, while the delay slot will be
>> filled with a NOP by the AS.
>>
>> After this patch the kernel fetches the DR correctly
>>
>> [    0.000000] Linux version 4.12.0-fritz+ (andrea@horizon) (gcc version 4.9.0 (GCC) ) #30 SMP
>> Tue Jun 6 20:52:40 CEST 2017
>> [    0.000000] SoC: xRX200 rev 1.2
>> [    0.000000] bootconsole [early0] enabled
>> [    0.000000] CPU0 revision is: 00019556 (MIPS 34Kc)
>> [    0.000000] MIPS: machine is FRITZ3370 - Fritz!Box WLAN 3370
>> [    0.000000] Determined physical RAM map:
>> [    0.000000]  memory: 08000000 @ 00000000 (usable)
>> [    0.000000] Detected 1 available secondary CPU(s)
>> [    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
>> [    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
>> [    0.000000] Zone ranges:
>> [    0.000000]   Normal   [mem 0x0000000000000000-0x0000000007ffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
>> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
>> [    0.000000] percpu: Embedded 15 pages/cpu @8110c000 s30176 r8192 d23072 u61440
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
>> [    0.000000] Kernel command line: rootwait root=/dev/sda1 console=ttyLTQ0
>> ...
>>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Jonas Gorski <jogo@openwrt.org>
>> Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>>
>> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
>> index cf05220..d1bb506 100644
>> --- a/arch/mips/kernel/head.S
>> +++ b/arch/mips/kernel/head.S
>> @@ -106,8 +106,8 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
>>   	beq		t0, t1, dtb_found
>>   #endif
>>   	li		t1, -2
>> -	beq		a0, t1, dtb_found
>>   	move		t2, a1
>> +	beq		a0, t1, dtb_found
>>   
>>   	li		t2, 0
>>   dtb_found:
>>
> 
> The fix looks correct. Without ".set noreorder" one should not

s/should/must/

> manually
> put instructions in the delay slot. This should be left to the AS as an
> option for optimization.

By definition, it is what the assembler does.  When ".set noreorder" is 
not in effect, the source code *must* be written as if branch delay 
slots do not exist.  There is no option here.

> 
> Acked-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>


Acked-by: David Daney <david.daney@cavium.com>

> 
