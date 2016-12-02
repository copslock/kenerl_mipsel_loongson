Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 20:06:42 +0100 (CET)
Received: from mail-by2nam03on0069.outbound.protection.outlook.com ([104.47.42.69]:9751
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993068AbcLBTGcfbjLj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Dec 2016 20:06:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ln1hWfee2WzdIxoNYmt+8jW7JKxz3QwyHPUf7+AGgvk=;
 b=oA4HYfWK2iSRkpa6IRLMVopg7pK0cVM8rLCdMC9Xb80yx4k/5C+fA/WnBvkrYwNeW972fyuLJoZkwYSTM/9sR8XCPPkLzPn+KTuXqrw7FVw2W0/M5Dhvs+in0FJUwtCJ7LJQYWBM9r6nMnIzi0W29f4FO4YuVfSF8ctSvXk70Zc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 DM5PR07MB3212.namprd07.prod.outlook.com (10.172.85.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.761.9; Fri, 2 Dec 2016 19:06:21 +0000
Subject: Re: [PATCH] MIPS: Use Makefile.postlink to insert relocations into
 vmlinux
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1478772133-32081-1-git-send-email-matt.redfearn@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <886bbe44-0ad5-dcaa-f27f-ab502e05b4a0@cavium.com>
Date:   Fri, 2 Dec 2016 13:06:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1478772133-32081-1-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: DM3PR12CA0034.namprd12.prod.outlook.com (10.164.12.172) To
 DM5PR07MB3212.namprd07.prod.outlook.com (10.172.85.150)
X-MS-Office365-Filtering-Correlation-Id: 4145656a-bb5b-4681-919c-08d41ae64e2b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:DM5PR07MB3212;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3212;3:1scHze9XtCnsOWZktR+pKZpYv8pqxfQtxWGd1JnJXXJsBLp+VQka97QmHpSF/Hasf/qMA+7KGJKvqP1JAlrlbP8Gxk9Wk03Ve0kMc/nAEnVHD/kf4ziW/PcnHrw8nDKhLdMSFsWMrpBU9Oekm8JQpRGvQ1TIdcjwjmzJ50SBZ3fK+it1Zy9pdhNoLhUbN4I6j9ySqwJF1UabUV0x4ZDQM5xBhDhpPXuVWTreja7T+tZOpH76Zjh89N9iFr3/8sWMAJ2+FfS0OpRk3wWJexEjbg==;25:U3UuNpCHx4n/oEz53KQzT1seso+l+0adJtKTbX2khSnJQeWBB1dCwsa+Vu7/qFESCYW99/Wo0dl04igIfElDmudmLAo6KxZJKIDyOLBvn2i8CbQJ+MbhiVE2sXz+zdnh+gwikADw83CIPxzQM6BVifrbEsK4agQAWf6aTK9P48/tuRM7b3+/GOq9p5ArVkW4L2wqWnC/jEx/HjXAr2V1vtZucEaOgKk2SVny2Ty4jTglB3Khq2zYTQXFb1Yi1oP2ij3bfaIlvvT5cwa9nCSX7n59/4ZqUXDj79m/0x05PEcu/RmCIHM+92NDUwMF59a0XH3C0EWs2j6cehBUF1x07eTVKOi0T/eo+3JcwTAhHaw3C3MK9ZdBjz/Rm1e4W0XPzcjyYZCiunEMDiOuTGHa6AF8G9yAoEXUJoXhrXS9+xlsocAt4xcLFn4PHgXAJkLrjNOlPVb5ueRHALnZMBQF9Q==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3212;31:3ffNOjtOTcAFBbMIxizBIovejmuL2V8aRECoFu/+0qOV5mV3BFiiQ/VT2zAgKW7wNVkbqFIL9iqWfFy7uw0rG9J9JsDMKECGrqBQJGfQDahEWXmmRpandhyU5KMiFzS3CwxBzAUoqx008dXP6OOq+m98JRYTY4Bga89i04cpEhS8yz4IPe2SnqL1l75TQohQH1XU0Ciup+Le5sD9IrMh2mP0vG7irXFB99es2KkSakX2e7ib6k3lHp6OzXXDJpywIARywFDLVXuU9W8wwa7AxPh+rsfoPbbIwaxPKFE6MsZfObot/Fuu0EU3kCeNWssm;20:mz+efZSa2PNP7Ya0nGoUHr8h6+RLp/eu6AAL2BB553vQTWGlEVnTldJALi6YllU1LWILsx9WXOwfiIgB4/k9KPo/ZvcYdnBu2W2WhlQE6HJMzyjsx7h66j6eI2se0zP4dkdJXvjPoHxxul7sGP4R5jHlM/A+33Bdc27mRI6wKpvYvgQBlfncSELr+LX9auPRUuLW218MHZJgcvYT3etNM4p2ASnVdqh2zZ7Df++6uDXxD0WF41Er/pfF7OEQPSP943u8XZT4rtq4XZXv56c7WuadX04NqwT2eCQyfilY8ljgecBQBP2wvt5L/GLmeAPiekqcrSdpcKZNVfKOvbGAB/hxoefC8Kh7D2V/dviWCZaJA1QS0oL8SDsSleHgnpWMItso/FXIQkRFKfboJZgoJbrtVOQqpUL8IrxuctpTGv4hWWBnyRO796pJtBWPOO+0geyl5D+698YeTUJkzT/r88/15bx1HCM7KCbN5dwoCHAePpQqTPAOIIk9FxUfzOHv
X-Microsoft-Antispam-PRVS: <DM5PR07MB3212D95B798C85DFDA56432F808E0@DM5PR07MB3212.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(20161123555025)(20161123562025)(20161123564025)(20161123560025)(6042181)(6072148);SRVR:DM5PR07MB3212;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3212;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3212;4:97jwzH933LfEExuHaKMjOgoFyb5eG9l6D6+hS006+gS9t+/IyDa2nkk8qqYW/AuzbLqkQMEWRXES++BmBpaPmYJfRRYdpctI3IoWBKi0FbAB/WcKmS+n90oVDgxiY+kUQYR8dL4NCANK9pRbSfIP+OOgEiu5a0vDfK0pKZDMhA/G23ACPSV8+8mRXxxtzXsPH3PNVg/M0UNadbXxYS/+tFzSghLrvnSGF+Ru8n/ZYH6J2QPopCdjWNl4MBEdDKcrd4UyCn80Sfa59mXJxJEXdTJGsauNFtUVb8J/hXtD4t9jkY8dT4+2mmVGlcry9Vq8Iq+GG7O+1U9PNY8+8Qk91tmzxOs5+3iUvhwZnIeKcTLPKDlNHLEL1KRYr3Blz7oatrkT2n9/nZum9RsQeL/YKOgmHHgFO+asNzAXCvtmY26TzqOEC1TUEoI6rBaJhyXxfMQe7UpCEYo1oOY+EsN70rTozKVHLZevIOHpgOZD5967SoLXao900OKqnGU5mLDMR1u0rml292aFUnkbaIp0N7f22wISI5ocahiywpYltORV2dIZ5odGSF3D0xkeyEF9Brfmu5CdUSzJq+4vTx33ng==
X-Forefront-PRVS: 0144B30E41
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(189002)(199003)(24454002)(377454003)(4001350100001)(97736004)(5001770100001)(47776003)(66066001)(6486002)(106356001)(65956001)(33646002)(65806001)(229853002)(2906002)(38730400001)(189998001)(105586002)(42186005)(92566002)(733004)(101416001)(54356999)(8676002)(76176999)(50986999)(4326007)(31686004)(23746002)(36756003)(65826007)(77096006)(6666003)(81166006)(90366009)(2950100002)(50466002)(31696002)(6116002)(81156014)(5660300001)(305945005)(86362001)(7736002)(7846002)(3846002)(64126003)(230700001)(83506001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3212;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DM5PR07MB3212;23:QsjTWzrNQP9uk+/lbCpG4fXuE8r/pP9BDa8FR?=
 =?Windows-1252?Q?jgIoeZqjKhV4Ekw9S2M930zHKkwT7gXCzGY9am6wlLy2EsdrFM1MwLGX?=
 =?Windows-1252?Q?UOxaYrCrkAmTX4QUZTXrPREJbf7/pi/e+Q9MRe9DBloY3WM5HoD3c63k?=
 =?Windows-1252?Q?TQX8HFweDx2ebtOaJ2sh913YDF/gTAfx/Up8OMFtvgYx2DUH8ZsOe1j9?=
 =?Windows-1252?Q?eeRhCDS7RiT1Yq62pmOlc7B/UvXr9T4JDQPX+Bwfbbw+fxu0CHLswkBX?=
 =?Windows-1252?Q?3I/PVIR3kFHs/2babYmonrD0qFgN7+6wpTDxm4Aoq0+/Yb5MdldOtAml?=
 =?Windows-1252?Q?3fQClNpuRkUTsq9ybL8zQGB06UFDGKHeqQw8C+U8kYcCSMhxSbkwX+3e?=
 =?Windows-1252?Q?+zhLcmAdHOY+X0G9EIVf3fdZcK7cnhCNY5CSu5Yd8x2NNRa2LEf/0oek?=
 =?Windows-1252?Q?CgNW5vahkQ/OPwu8i2t3Ts4KUJWBS6UhJ341nCm3BCl191fjXOEByJLQ?=
 =?Windows-1252?Q?+JRdUWR+iUcuQ+RmWACarmSx/zieIq+8CZ1Ialw3evP95LqmYJCdiw+P?=
 =?Windows-1252?Q?Ko8vmUWnp+fmpBrPXy1veLRUkrFTfocALUw+p99DBEKzgexC4N8GBrxb?=
 =?Windows-1252?Q?3z7hQtEVkruYUr6Vn5KgKc5lmSKjAl5wtTAUVQ0BCqfJy/Q7OMnw5BqV?=
 =?Windows-1252?Q?WXRS8MXHw6XDetSrM8SYfLzf16KTf5EWjl8xcHN9CZTFPM1eWOcsYQmU?=
 =?Windows-1252?Q?2tpjdQCWf2WYtLrc4/GESshyaoyL5b0mZ5Shtt9ACJzJEB+Q3CXBBRL3?=
 =?Windows-1252?Q?AAnWH6TqItwNxspZqvYhXaMXYG1LKetNBI3ZsAq1ZLZKt7WH8FcYpjEC?=
 =?Windows-1252?Q?hCbureISbZbD/slmtYEMAecpjjkDwQe8tpezKuvvC8ZRAjNn3SM1hLkS?=
 =?Windows-1252?Q?wjgepvlgHzMP5/t/bc/wuiQOnJHjxbRlbAXNYCSUGZjESKp/AKnJZdTV?=
 =?Windows-1252?Q?MAPY0isJpAkr6zqQosJmeoninDBQ4eDBgDhu9eaowAJxdLxvF9nIl/Pq?=
 =?Windows-1252?Q?4loodJTbUXMo+da23R8DHtp0WV4kULfnW6NYWaDrgc6BDWifkwJmtFYN?=
 =?Windows-1252?Q?UR2/F9BOXac/4CMuyuNh8qWg15VT5Glp1vkCt3ulUXFiy5mXkfCT7xTk?=
 =?Windows-1252?Q?5OWCMfPPfqsKUs2ka7VVKnuWmuBRWBk5zfE0Lm1IKwxOTo+k36y4QWgd?=
 =?Windows-1252?Q?9ZnGDUGOkFo/x/yaIs4W0N+NVSCSiRJ9IKt9scQ+Y4gPBLBxBdunxSSa?=
 =?Windows-1252?Q?dXES1q30luVoN9wsI3wIFAGJt9I3UzraDmr06hCSF3sR3dgmXFzDGGMA?=
 =?Windows-1252?Q?DOSNVPf/crCL1mDWtX1xHa5+cisqRND8ctmKUKtWVkEpcNfQ5gb3U4?=
 =?Windows-1252?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3212;6:ld9tWv2B2EqSTC43wsSrpy9d9PMbBClx5wpa8xsjmfE9hwJXXRxx1xBvYXt2MhG2si5mt42ctDG5j6/dQGhjC3c3LYlu7x95CWW3P5yZokHFKEnbYmvGVax+OeJu/SMCtPVqU2UI9m6Imj2MDxQ6EMDwarvmv19wG2qFFUXtmwy05TYkWJiQuWuF6/0OKgVtbsmJZCHcaf4XVLgTZy/8ujgbSV3jFv5m1OYd9FGUkFsNTbuqHZ0ajd2pnKtS+/XGiOJBLha0ZBTAnc2CZ6o/ja2DooxRefxG40jHrzjMtptetw5nXKBcdZ8BYw7tvIPc1al4fSD9+txD2vnez/8VoQdX3CZk+vl1X1n0fw7lFxDLaTNgqjIjWNvAeIE1bHT+ImDyaQ++1qn5omLG+qTlj6QjLWI5N/7vVHLzB8j8+Rgoh14+G3RWaUhHlDGggUEQ/qfUkieeQHvKUzCT94oq8w==;5:5fur4w/Fq6p2gabeRXZ/zS3hvKV4ZG90llYJmVbN72yow+WoLcpn9uhbaXbVNHRgpGlKFFjzYHFhweEaeIf0claFcyDjR5ZmXnKYLpY1F9q/VDMsBYkuzNDRWS7BkKIcFPwy2RFqI1PbM5LKTRD2nA==;24:OlgSCP4sh8MRUgdyH805UZ7kT2PuojiAI3LnSc8KAkKLucUSwaT1WCJvYjQfNwEhQWusJY/FESFXXXMlNJNZxGeSJ3LLUYjxUwK3iwtevek=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3212;7:05Dqfcly6y8FqJHGLnjJNRau24lptK4Meme/7bLZROLlSvQeA6esQyk5fB15P4X2Vs+4y5w8RyYbMmIoC0F11JAXOPRuUdPbbO4dV7Nnj2GnSIkB8p4lCjSJHS982bttaz+H25u23L2o8r83h4HLD1XBJQk+Rzdjn7/+GLKq6zDTWJf/2eeAsd4P1SCJQ4qnY/BRXSdU+jXpHcudbghjcIXVhjXKmjDLeQ59/H6CqhdqJdRaRJCRV78QdEiHLlRTUxpO7DOm2It4OCBpSI2luK4Tp8Ncjk/GR7VmOqdJ0dwaoABs2Mqa+OLj61189b/8kw1UEvmLXcwy0N+5RTbI2JAFFn3O9+CKJg9Fc5+aF0bMUrBUMI/tulSG3vlrZ79SXgWrpbTCuiqu80aORs1PQKwrzaXf8GDHoLhJg5NRhr0PBZbKiJqoggOhl+xYx/krF0ZVSeOoTFzahXrHb3ouLw==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2016 19:06:21.8227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3212
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55934
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

On 11/10/2016 04:02 AM, Matt Redfearn wrote:
> When relocatable support for MIPS was merged, there was no support for
> an architecture to add a postlink step for vmlinux. This meant that only
> invoking a target within the boot directory, such as uImage, caused the
> relocations to be inserted into vmlinux. Building just the vmlinux
> target would result in a relocatable kernel with no relocation
> information present.
> 
> Commit fbe6e37dab97 ("kbuild: add arch specific post-link Makefile")
> recified this situation, so MIPS can now define a postlink step to add
> relocation information into vmlinux, and remove the additional steps
> tacked onto boot targets.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>
Tested on OCTEON III with relocatable kernel.

Tested-by: Steven J. Hill <steven.hill@cavium.com>
