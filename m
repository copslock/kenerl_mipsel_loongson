Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 13:26:28 +0100 (CET)
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com ([104.47.32.63]:49408
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993008AbcKWM0WZTbxP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2016 13:26:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UjEk5+/3v78YvCOA6nLHVaz7Yjp/rx2MPQ1oh0b6sCQ=;
 b=g8jjAJh4C4xUM8accWlCCVRiefYCtZsnUmgYmi7AVKXZ6wfJuQNBcSQ+UrRgc94IJ0J9NXFdyidvKZred50tTDKpb7F+4Fnn4lfkfSZrsERTe8sfGPfHtqSs3zH3NQbMaaq1l1WzdQfVsxPQ04/qmqMXuRZE5zzfdrZGVrTRMBU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 BN6PR07MB3201.namprd07.prod.outlook.com (10.172.105.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.734.8; Wed, 23 Nov 2016 12:26:15 +0000
Subject: Re: [PATCH 0/5] Enable KASLR for OCTEON platforms.
To:     <linux-mips@linux-mips.org>
References: <088264c9-75b8-37ff-6514-0f536b1f8e55@cavium.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <954fe857-52c8-cab2-d947-db2b0673f7a1@cavium.com>
Date:   Wed, 23 Nov 2016 06:26:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <088264c9-75b8-37ff-6514-0f536b1f8e55@cavium.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: BLUPR14CA0080.namprd14.prod.outlook.com (10.163.209.176) To
 BN6PR07MB3201.namprd07.prod.outlook.com (10.172.105.147)
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;2:CCvlA6h2M4puX+BLZ9EC/5fdNQpwbf7sTzIXlb/34n/KPLO03gHoE/PNFQ4Je7eRjZA9Yv7LM5b5TRV9x6YwILR1/ahFuKU5LWpHZepdYFERdjHaxCobHFH8UoEzivBSaSEA7k+aAwwirK+dQ6wmpwdGULKTTpwSj8SstMmEW2o=;3:7soQEq9m+GxVcN5NRTcwRPXgJZhwjitp0fissGhFsYm9FfF+PIi99UgbqVlA7siRrC3S0ndYJlngoLWOZre9UxXwgnNHumtwYrsSUGScuRvyUugcUwR8oZurxBC+suC1NxK5ULUODnyFg7wXRNWvnNhelG4LUzbB2iyoAltFOew=;25:UP8rORkqUppb1kwAFg+G8RUPswGclQA5ngZ/0XsYdj0yylHT1nZgI9rKREz0wexBmdaCYceSm/BQOlM5oiiIpYr+NSBozzmy3d6JQp6IH1SJIHiKBv4fGTgvXhGy3/lKTqBMXJx2ir+JCUanskpjFyx72OmWuavxkw50kb1z7bw47tllYLD0RnnZyVF9U/4PGytb4JzXkMzFvqF5njhy1/uBeGIDTk5t68zPkMc/24ezXwVJgadQ6lRCeOyUe4/w8FbmjY2QPo/XyyMORmby24l01oCgi/ri4EQL4HtmMTmTv0Tq15vGRMXZUaCHxgN0Qy2pfm8F4ETJv7+8eD9DqDAcXHdZ1AOoM9++imkfxCVCNM6sb64kxpQJGttXKyl8W1Lq2gkZTx78aLcLaSLGiyzzXkhYccaOPVUuZMZ9xTQm/sgPoU7OP0tSeDq3WfWsKGiFl3PlLJyK+8MbhfLj1Q==
X-MS-Office365-Filtering-Correlation-Id: 80975bf6-8820-4c7f-28c2-08d4139beb75
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BN6PR07MB3201;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;31:JxPNyHOIqDLe8VNbNXouovJbgCTUlBPVxzRB1IfFk48lJUURhnekrp9NUrkpWqrCkhMh/E2sFWnklky3JLwYhSGxb/xnEeqnlyp9cb0aRK7LVDAZ0cjdPFWMpzHsKzBsPsabWV/DIC3Espsekl+qdxbhC0nKaTwkDff7mo6XVpKvWPBV0/2pRcOf/+OwmrOl/QRueCPmq6wDPVr4nXjUecl9pYTwLvcp09swKxLPmDi4FAgb17e4Qe4NbFbZQ4z4Zh+CKz8oBxXyLYru7fdEnWpNim42p/DsQZ02RkVKmsE=;20:juzwBzEStz0J+hv9tCFjsmk/1T0BjJYbSiTk+8Cxq39keEGOjhTAOqQaoEljEEJ8SUBKWJZQ/4l0yqmUUCDgfa7Z4iVKxHr4BkSc89OAUeb2xfbkVpa19C5Bbj+1Uv19XLZtp6lgsbAg+KyZcxhSnqQ7Subx0vrrdB2NXZJrD36viKEmlaa68xsggEu9f5yXF+robGeK8HcAF4AZ9oJsmUKElsL+fkMZKV7kjU7n3siir4lvLS0sxzjh0xOttEoLlFNBZZl5zy+hO2yb1/nYne77o5BOD46NVPStRXRtxePgg7Cb3L/P29PtbReXUaZqNyZP8//5Ln92Zxy2sXVnwhOPVxnXOKshZH3cGm2A9p5+LXziGDYC9sn0XsAyb/lgWbSO8K8o6eHWAkzWa8XMOE0UqEYP8EEAiyUHqbfz1lnqnKmw2rHsBlxiShrLRFirL3y+F7IWp1fv4R+7hiCll/Mn+K3JvkNyiXRhpbOhhTbdcYYub7VAA9Z8jgOMlaH8
X-Microsoft-Antispam-PRVS: <BN6PR07MB3201A539EE6EAFBB11FE54FA80B70@BN6PR07MB3201.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6045199)(6040307)(6060326)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(6061324);SRVR:BN6PR07MB3201;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3201;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;4:JmetRfbEfGcCDhmfZCcdsH98xdMh857H4/ns2tsHhWe5EkWMovulKaNFLxq1NBg0+iHB9O7NeN+A9oYHSZox9E6cPpEJBZIbygjpDmKEt+pz9v0m5HwraZ4D/sMq18Vlhej5VrZ+lGEbs/OoYSxtgkSYpjGAy6RNqr66YdxC+DHN4O7leI0rWqZDT2/oEHQucGu1oRJRq1fnb7LQjeEwO91j2eW2mNbkszGiyZBaHaBSVBRN4mDYVHVgQpQUR/s7UGwVUsNtwoA2iOagSy+2NGdvTZdD++gNdbqYEQm29fPtxvu1ON4ioTPQCq/ZsMrDhNCEIQIdepA+NcxU9hixll3tpjBeiC/pGJ+zm5flih8cPda9eB4IKd155J2IJQzlvPoVxtL2o7saRIVtpxmeImskbPLbX9dujNUOcFOWuYG8s0tAJdMLBlC52T8zoactH/vMARxjBkbNK7qbfjoiaOxCSyFEOib41mdSVbI8lR0=
X-Forefront-PRVS: 013568035E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(199003)(377454003)(24454002)(189002)(47776003)(66066001)(65806001)(65956001)(450100001)(50466002)(77096005)(33646002)(83506001)(86362001)(229853002)(2906002)(65826007)(38730400001)(6666003)(110136003)(6916009)(2950100002)(23676002)(5660300001)(6116002)(3846002)(97736004)(107886002)(189998001)(50986999)(101416001)(4001350100001)(54356999)(76176999)(105586002)(106356001)(68736007)(2351001)(64126003)(81166006)(36756003)(8676002)(92566002)(81156014)(305945005)(31686004)(31696002)(7846002)(7736002)(230700001)(42186005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3201;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzMjAxOzIzOmxXRytZb2xzWU9UWk1yMXpqeW5PK0xHTmZU?=
 =?utf-8?B?dkVlNFBPOFpaVDlncC9aZmtpcUJ5SkEycGJFQTRGRlgzUVRwRC9RTzcyaTNs?=
 =?utf-8?B?NDNHZGovT1ExSFBOQ2x2bnhXWHI1UFdEdFBvYzFQTkxkdUJVckFBQkdLT1VY?=
 =?utf-8?B?UlRKNTVkQVgycVY0M256NzdjS1BSZDhycDdvVS91aGlCRGR6V1pURXo5Q3dL?=
 =?utf-8?B?VUpJZWw3ZFlvUytoaHZqL2x0Q3k4QjBvc21sMk1qZjI3SDZYVzVacGtZM3pJ?=
 =?utf-8?B?MlhjZmFlbjZXeEpXSjljQ3JXaHdaY25oQVJFN1BrWDdYb3hjb2hwN2F1S1RI?=
 =?utf-8?B?bUl5K3RtM1FyN2lXNWIrUUY3SE94aS9kcUYyc2loOEpzaTBKc3ViTlFadTB1?=
 =?utf-8?B?bllFT21neGhqc1ZEc1Uza09DZVpWWnkvN01pNURPcENVNmJvb3k1dWJld1k3?=
 =?utf-8?B?aVBlNzE5QzNaYTFLOEF4TDgrR2xPRVdSWDB1RnlTcU51VHFkaWFrejlvL2lB?=
 =?utf-8?B?MThYeUdkS3E4K3FxVFNXZW9oandnZnZjY0cxR1UrQzE1ZXlaTkhlSWNJd3Ns?=
 =?utf-8?B?V0k4cFJOdmhqclZGK1JGNGNka3d3UWcwcmh4UDZVd1FoUjI5VGVhRlVNcmYz?=
 =?utf-8?B?TnByK3IwRENKa2JNTTg4UldPS2ZMZjRiOFBnWWxUQnNBUUpuVzYydmVPM3Zu?=
 =?utf-8?B?Tkpnbk5aM1J0QXZQVnpqVFVBK1JzZmd4NVg2VWp3bm5qaGJYSTc3emFLWnp1?=
 =?utf-8?B?eHptSkJvZklkWjNLc3lMS0cxTmhHT3hyWGo2T25JbVF4OHNDTmg4amhQZG5k?=
 =?utf-8?B?dmluUFRveFZLVWdnM1VlMFNOZWJqWE80L1RaNkMyNEZTNUs2WE5HMklleHdL?=
 =?utf-8?B?TDBpK3JESktOSnQ4MmNYVXpzUWYzTFg2ekpBR0ZZOFFxSXlwWXZqaTV0ZFoz?=
 =?utf-8?B?SWNrTE1USG42QTg0dzZmdlczb3lNaVloaUFBY2wrNkh0VUVMc3ZwSW1qRXRE?=
 =?utf-8?B?VDQ3czRXTWVRZlNZZTNYNG5WeTJCVExBQ2RadTNiU21sQ0hEL09ER05iQUpj?=
 =?utf-8?B?d0xtb2lJYk4rMDdvdHVjd0J1ZkhKN1ZPbzJuclhzaUt4TGEwTFgrS2xTVHVY?=
 =?utf-8?B?MndoN1NoSkk2NXR5RFAyV2kwZytCOXRuNHVSdVUzTUVTbjhDZ2QvRDdJZ1l6?=
 =?utf-8?B?STE5c1lhZEJ6Wnh3R3FxZXFseTg1d0VCWHNYWHgvOTFKU0hyUTFWRFBMOCtR?=
 =?utf-8?B?QnFUSGp4bkdqS1plUFNVVjdwL01lZkNoWjhISlNrd3dYbkxOa01rU1p0TCts?=
 =?utf-8?B?SHhkV0RkSWtBWFRPN0htVmdqNWtTbXZwVTZyRlZLTE5LMGFHTmJvYVdESkZM?=
 =?utf-8?B?VTRDcHVENGFSYjhvNUtJWUJ6b3h5VXg1ZkU1SFBOOUlrcGJwRis2aG9UZGRx?=
 =?utf-8?B?QVIxNzcyYTNTVUY5QXp5NXZ0VUZBajNlbGEvRHNLKytpZGVWOGFjdVI1OUhF?=
 =?utf-8?B?aTRJcEg5Q21JU1RZY2lwQUp1S0J5cnNJQ1VpdzJtRzZ4NG1wZlVTRTZ3c2Zt?=
 =?utf-8?B?L1BIN3VTZzFXcmZaRXBiRFB5Tkdkcno4TTJ5dHRZdjlpTmNKZysvaS9YYkRq?=
 =?utf-8?B?cmZ2SFMyRjdJNklVVnVkZUFIdW0xWFBKK2JoRG9zVXQyVHoxUEI3dWc4UTNi?=
 =?utf-8?B?SG5lQm5uSWVLSFRtT2l6cU9VTUg3dHJsMDVvaUt1cGsvczJJeXF5bUJkM2hi?=
 =?utf-8?B?dmxGM3Q5bVRyZ3I1VVlQUGo5dFJZQU5aZG9VdTIrdE9SeE1VdVR6U3lIS1Mx?=
 =?utf-8?B?cmpRQlBpeWM3dFBpNkFvREo2RW5ZVnlVV1VrbkNicElvN0E9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;6:HDwfbwaR6eWM8JqkCkEeJ2t8DBGw3veS10yB9NMmmYbNjF5IG15Q80dwaRSEzXxaIZ618JgQHGiegYjuDoht3z0nfNgcxdWDVptR7+UcN2iBsGV6+PlHXElAyRwstxoU8/KjFOqCBzP6U1m8mBngm7YeyGu6R+kEifN6CWqEgriOzscz2l6Ur5JliDErJBeadE8H7NNCYwnRkwo9GVoTVQhdredhuAiWxnvOu7Prsn/vDzUIuQD+Ld85rtGgxl+QOpOgJin8pnHJ7XyY/GNnB9bBHTZR4ukm5s65gXltHxpuPOB3cwfZE2r1cJpegACmApzboraIKWVG2xJDxLql1BFVLL3WwLQaPL7AuEtGt1s=;5:yzapVfeSRX+9RKPVs9eLrzJVTSDv1sj6AzUGOeSUvcVkhg4ckuIbbFn9CmlMyoomAUB3rxcXGn4BZqAJlFxD7fXgcwUp4lC8SHQ8KWi5kn0wVyrliYoN3dT87302H5ziCX92pjsBrqWhZ2B9ykt9sA==;24:zWHxLtVMvheJm+r2AEVIEL+8MNximXzVWb7VjQu+Vfx0/T4mMq2sDNiT76YUMOMbw3WUcso3tO5Wjs4N/cmYirbyubRPMQ1TYvdgs4Tp5rY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3201;7:ybVN5BnFSItnSd0Rqu98FOo+H17Iv1nrMRx6qt7oJSYd7P+A8TQTQ0WuqDeurBd8FLpphZK6MVAxl3OMrqX2eGCuAuQ29aJER2LdEJRVtDEnOc6mLYcRoBTXLrFuOrkLuCpiR4qiFn9Onyyn6mBT+THzGc073Km1Cbh9ZEzI5PJTLpsbr7ye0tvFeEKfqIrGk986ji92Qj1V1vPz20k9cDFLfgXQxjB4OyAcbP3ylXLnNS8NluMvIe0cp8j11oE1TH7OP58WbC5hX9swoyq3eCULt8+GP7+kGA1CVLQAidKdK0m8fY9RKOWnQy4hySPuEPZk2uCPCTRKdGrxvM/nSmnyYfrb+V906hYvbu9TyWE=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2016 12:26:15.5233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3201
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55869
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

On 11/22/2016 01:43 PM, Steven J. Hill wrote:
> This patchset enables support of KASLR for OCTEON platforms.
> 
> Steven J. Hill (5):
>   MIPS: FW: Make fw_init_cmdline() to be __weak.
>   MIPS: Fix vmlinux.64 target for CONFIG_RELOCATABLE
>   MIPS: OCTEON: Add fw_init_cmdline() for Cavium platforms.
>   MIPS: OCTEON: Add plat_get_fdt() function for Cavium platforms.
>   MIPS: OCTEON: Enable KASLR
> 
>  arch/mips/Kconfig               |  3 ++-
>  arch/mips/Makefile              |  5 +++++
>  arch/mips/cavium-octeon/setup.c | 23 +++++++++++++++++++++++
>  arch/mips/include/asm/fw/fw.h   |  2 +-
>  4 files changed, 31 insertions(+), 2 deletions(-)
> 
My apologies for the incomplete patchset. I pulled the trigger a
little early and did not include the code necessary for SMP to
work properly. I will do a second version for patch 5/5 only.

Steve
