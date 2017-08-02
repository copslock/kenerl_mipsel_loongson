Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 19:40:18 +0200 (CEST)
Received: from mail-bn3nam01on0084.outbound.protection.outlook.com ([104.47.33.84]:23264
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994847AbdHBRkAbsKR0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Aug 2017 19:40:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0uYiOdu+i/GTwHDiRQ7w5jNxqwanSGLbADjvhZLOzfc=;
 b=b/2gyihtWRmYqnP01+qbGkHYducwbkkMEm5zekBX6L50KxH40cK4/UN+4JTNR8gw9kUA5/qpqmFWgbP6151csWQY2isuqiFRbNeSUS6SK5Yef3lbGSMBUWbIe3G5/ktxSyyYTT9i/igPdMFaWZA1EFFDx591N1NVlQjZlbksXVU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM2PR0701MB1231.namprd07.prod.outlook.com (2a01:111:e400:5031::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1304.22; Wed, 2
 Aug 2017 17:39:52 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2] MIPS: OCTEON: Fix USB platform code breakage.
Date:   Wed,  2 Aug 2017 12:39:50 -0500
Message-Id: <1501695590-26096-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CO2PR07CA0078.namprd07.prod.outlook.com (2603:10b6:100::46)
 To DM2PR0701MB1231.namprd07.prod.outlook.com (2a01:111:e400:5031::17)
X-MS-Office365-Filtering-Correlation-Id: 3e6f029e-9bd4-4d08-1c93-08d4d9cd7bc8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM2PR0701MB1231;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1231;3:f1hPvLDZYuHQRbS4M16NXlMvfVhBhK2KOOV1eqxNCtS9HrC4Ds9b5fuPsBydpu2pP/kAIi2k6H/luEHwoN7lU7kqFDVSFAg4OZX/YItO9Jbg+OYkzhpEwpbJ5J0g1e/eQG/HQupvo4n7yL70ptaNl/6oRWxj7Q0B4ev29++abETgWXG9TI2VJ1cngNYQaocNV6sqgNpwkESzGcRfsqDHdiH7N/nVy5Egcoo8LYrbJG6b632LKHP/STs9meGk8ChfSde+bpeLP4IjOeglzFV8Ps2LoEGp3DG+doMGnYq/qsCfwq6973tJr4ZCtYztREc/jbUVLLFc4AmqmAL9wJ9G1aBGtACwQcI3sftdiUYBFlJZ9rEmQFQHb1GEYuXs7x+cLSknbGiKGw5l+3SG3CAFMEW4EUnwFcJWZDfeRn2c7GAdG5TajgoFZ/qTwHdnwP/vsu6b095hV4IrU3O4BPkdGLlaUFsfoKrgoeR60wFindplDtYorclJEHQ70eV2ZVo8RziswrBK6PHN6w/NcPZlzc38VO+uHU9aMJD3YgXncCcvX7LdjMGedVrOLLE1tvCnSUgj/6aJH6By6EujdxKnQXoFkqZLIn8ezdyOGmvRMSqKVAfPBTbAnKzRS37lUcRgMELCU4d+ZbKEdVuI4OeV10w/VZUQ7lb1VVZcDMOd5KvgJ3j7HIRg1wed7dOwrg0UgKxq1OI8lr+i+H0x12ZscH5h5ZD+dEJHjG/6P09Nd63wbF/9bQZldbneAyseA0iIgb+OP1OR2Dre5ZYqNycz1QctwonwTEwyYpQJGh8mrHFR06+QyYIDVj7QHyZxmz2u
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PR0701MB1231:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1231;25:m9Fu5ZvwPEqeFptWW1yVf1tydJiLHXz38F+ZgDKaRSbfV3qnfIWf+XSlIfDVynAKTxiAfAvYrK6z3LL56DDn10XzvhQsePSINWEeKEZIX8pVRK6BNJl8crQqcSt++LxcCxo/Hj1YT2NHISmfguWJ2LMJaqYMUZKEFBC4yInS6EeJ1adU79xsNMXGPA5W2HuiL0fSBmIhfz1qWM2GNmIcdB06CPdCRpIMBldcRjT3jNjKhbXccnXzVCIVvod7gcam3CNcUGsoPAy4+o4gAUAxHLnxVwf4aAJJzgYrvKaoetfWq23E1jr8sQhUDBuaxvlRXXxMgKD0wuRRaB++5uuYUa1hjVk1hgrbMJw3JXlPvJphAEfRi0Lh3O+HDSmrTrDrl0/ZTxOV7HuMIjLeoeKufp4uvQopNt3yrTLNIDsCBMJbAtvLDyvYaqtgrSradoe/GRcj3xCH2GK389542HWKu7thX6ap9FOjK95Deh6eTs5Lw5hGlmx5ckImdYb1zvulnQO3hZWGBj/hKdx1LjVZ8Ah9RNbwEqPQZne6zVkB+3oGctgLV8I7Huni42LXyfsfWDIcxfsaMt5LncRMF8xg5Cw4ziGf8nyJssS2D8ij1IM1NDmq0VwTPa67hIE81MpyGimcaaTBZwM7jN+4u5sND2FEWQnvQA8tYdC9sua7dH48HQvtkttnEpmt7pmW/zgbdKMMlDZaWms6zpjBPXHlj2Ei0qwyqZdDikU2lrdoPRvyonpwWaXCJREkXyfjWRzXl0WG1AIKz1GKY38xI66eax91Bo01BF4xZcRJw92JxlNNiaTbMp+zhkSJKzlCYKO/JnyH4qBAsFTGF5gKPeyiZN7nP2yXYu0gzGzsQpnUG4V7vnPGuRF4Je2+beeQJK+l1zJ3w93aPYyLp2YIg8nr3RkzUn8Mmwalveek7Gm3KnQ=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1231;31:wHnDr1GlQsPEAsP5FwyD5/xrK5nfN8iKWd4EyUX/ooB8Hx6rDq9kSUjL7I29183LTQjTpsWfMOZk7LKYlDRb8Fdf8myXQEmkNgLiBJ3gifPvR+FI5MW7Jj4Mej63tywbcU0vbnc5Kt0f8j8zreuEVxCeFbz6NV0McbuP/g2c/uOBqeBR8nRKxTqu5IC89VTyiohFBUul+y+oPuUqAdI5y7IENBwKyzqEUSAPTU4TziU/WUHJ+m/IsGx4KopMi2MXw4H/1w0Jl/vODC+a/dfWRDHOd9DpLpi+50ktlF7jD3ZwzkqERU/tPZOIApTOjcIprpBT6lvdhrUaxzzpAmc/AfSpf/jxCKd/SJR5HlQH2Q95z64f5yYp/7znr/4qSI1zSqw3+Mgs6wbU2EyHCXml4TbekGVbIpxc9iwI0NyN2PWhLmQS1Nm4Fc0K5UEzbYgO00DXRqFC3enWX5NENfdRthv4wjNn3Ln8KL4ZTRyAO1+kssvWtj1GjMUZ/GKrfIGm7zL/o87zcsf/Y9w76Eo6xM2+4Komu00QR+OmUzJ3yDhQE75uFK2a0E7qv75hMEWacLL6vtgXNPJMbShj7Z5Sfpz07wEJfwznF6jswQKUtFjfcpU+rMVtFUJI4FuWq1xpDtOg/HjgbxeIIz0KLFYjk/ppuOlxl8ue8QcAlgY+WwGALvq2bQxvmAxj0r3JOkxSd1B/CMRNv0q6mzPSSmIWcg==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1231;20:KEoShYCgCnjTV163TmetryZUXFVkLfUr2F/XzrNyCv2edmvOWh1Ef6LJQyhAl/6+DkpISkeMkQsi8m+b/weNKuLly0mlmAp+TqG6rJLdnR1qrCxb/GhxzqV8RkpYShoqY2bHspg3ppsHWlyGmigjpv1bzQvpZ2F8hWt15XvbFqOgnmpoCqSK008MVqO/cQ+QKASrE31O05+KSpwpWS0ZlLc7PSNav3EZvKI9sGEC9nkkQsdJJk8jjvAnI/mkmSrtf8Hkczv0+RmGiWki23avU45BIgpBoeVv7uxiERi6TBIPNZZbZloi3nR0E8yE+nYGN8W+CG4EPF2y1XJJW6CEdMGD0gtC+L6IqbMTOB6cHNIzOQrxXCNUTMRZVbBcpwVh1xiQ4V3qJA19zB/cZeNipBd62XsfHK4l3Zo51BffiJnrx4PzYh8zjaX44cdcw3ThxdfsqzGoKidqpJZKSMkEcPLCgnhkMAbJt+tXCFAoY0zLCpG7bCyKzJvGn3UM2jbT
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM2PR0701MB12310105F8C8D2D2A1F9A68180B00@DM2PR0701MB1231.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(100000703101)(100105400095)(93006095)(93001095)(6041248)(20161123558100)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123562025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR0701MB1231;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR0701MB1231;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjA3MDFNQjEyMzE7NDppRk9GdU5VMGNyeFQ2dC95aktLSmZ3RFNm?=
 =?utf-8?B?R055ZmNNbzIxcmNGbDFjb1Z4clNlVm85ZnNvUnlZTFEyREpXNi9sM2ZQMTFs?=
 =?utf-8?B?NWJlREp6clo3UUd4aWpDYUN3RHpIeWE3VUEzSnlvL3RjWWpSU1lKRGNnVkE0?=
 =?utf-8?B?V0RPZit6cUh2OU9Ec05XSTZ3b0xzOUl0ZXZ5c3pCUlFxK05ubnVHYkcrTmVr?=
 =?utf-8?B?RnZJckE0ems1RjY5SnRSV0tsOGZWR29PZVBqZjlrNXdDT3BwK1ZjQkFvSGNV?=
 =?utf-8?B?S3lwNW1NemVvNjFtZlJraGZ6bTFvMThDSVV3ZlkzSmhRUndUWFJYc2VHeFNl?=
 =?utf-8?B?RjVvUDZLaU4wVk5pWnhMNjlDeXh1QjVVbkYyVmxHaFNTajIzdWtNLzV2RUR3?=
 =?utf-8?B?Umw0VTVjZTUzcEg0VzJ6cFBGaHl2VWNNS0RyQ3U0bEFBVFBmVjlRSE9sVkRO?=
 =?utf-8?B?N0FSWk1RWitTcXlMc1pCNE80QUhoVjJBMUxTVEFOdjBXWGptVXIwSTBrNXhJ?=
 =?utf-8?B?MGFJbUZqK1k1VGc2aHYyN2VNVENZaDJyUllvSFV3TTgyMFlrVkUrRTB1ZDY2?=
 =?utf-8?B?N2VTNFJkNzF5dy9jN0h6TGw3alVEUUxiNnFtNGovVXVlVEZDQndsZUFoL2pK?=
 =?utf-8?B?K254TVdaZURURUowUlZaNXlHbmMzWUp1ZGlIT2VHRTZwUHBJTEtkTEZwbjdG?=
 =?utf-8?B?QWFwdUkzVHZRQWIxS0hFekpmYzdxbVE2ZHpMSmNpRk1pMjBVOVZ1dlpDSkx3?=
 =?utf-8?B?VVp1V0cwaDlheDlITGlvR0h0MjJtWWNXZjlkakNybFdVUFNGWHNPcktzMUtn?=
 =?utf-8?B?aVI3bFgwcTR3RVgrOUR1bVNPeVRKSG4wY2NRb0REY1RnajB1VUQzUkxyNXJm?=
 =?utf-8?B?MlJiWi9VdXFOSWNneTdyNFNhekNaNlFKSkNia1N2RGpKUVRsMWdoalZxaHhX?=
 =?utf-8?B?K3dlWlFjNjlnZ09KWjBsam12c0h1aCtzT2hBVXVsaUR5K2Q1d09yeHY3OFh1?=
 =?utf-8?B?a1FqTkJhN0dvYVJoOXE5ckhuZ2hnRjFZWTNKWlpmMlMyRHZRMWdLY1hIK1V3?=
 =?utf-8?B?VHN1czZXaGtNS0lrVEVFM0JObFl4MmQwWWlWWWJZNWNzSlAwTXRnNDhQM2Vo?=
 =?utf-8?B?RGp5enA4UWp5SHA2RzhlWHNVT3VNZnlBLzJXaXRrQ2huNFRqMkJhOUxIZmVy?=
 =?utf-8?B?QnZYOHUyeWtHeEIrK1FOYys5TWpzNnBaSkZza0JrVDdWN3g2eVhnb3gwckZt?=
 =?utf-8?B?ckQvYlFHZWtkblpVYjVNcjRFMEtXRjBWUGVzWWRORmJvT1pHSE4yc1kzZmEr?=
 =?utf-8?B?eDBTaEFJSnVOWjhvNWNTTS96WmhqR09Rb1ptZUpRWmZrbllBeFFhckNMWGsz?=
 =?utf-8?B?bHNwWGFGbHFleng5T0ZEU1duWmhYOUc1M25vQkJKdjRDWUFBQ1FLZkNXSklR?=
 =?utf-8?B?ODNQZ2xoTEc1OEpyWnJ1aHQvOVBoNXUwSmhTeTVPTHRlOSt0eTFiWXhBZ210?=
 =?utf-8?Q?nm6WPa8nOtHsYD2h9b4ESPGdq5OyjhV6yscH+6aZi8G+4RZ?=
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(7370300001)(6009001)(39840400002)(39410400002)(39400400002)(39850400002)(39450400003)(189002)(199003)(81166006)(69596002)(189998001)(47776003)(450100002)(5660300001)(42186005)(33646002)(110136004)(2870700001)(2361001)(53936002)(7350300001)(38730400002)(6916009)(6486002)(86362001)(3846002)(105586002)(72206003)(25786009)(101416001)(6506006)(36756003)(50466002)(8676002)(7736002)(81156014)(4326008)(50226002)(53416004)(66066001)(97736004)(50986999)(2906002)(305945005)(2351001)(106356001)(68736007)(6116002)(478600001)(6512007)(23676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0701MB1231;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjA3MDFNQjEyMzE7MjM6V0F4VnBhSENvbkRLVWpDVHZ0eG83SVJj?=
 =?utf-8?B?SmVWbFdXeFdHSmppd0IrY2ViYmhMZS91ZTJNNEdGMW9haUpZd25YZU1oa3Br?=
 =?utf-8?B?T0RJZTM2eEFLd3VOZjdqY05xNjlaTW9UZDZlYk5mUDVXdmJQOXg4azBkQzUr?=
 =?utf-8?B?SHpkNGpoMHBheU0zL3NTQmRyQm5rKzZDZWlOUU9zMXczMjdDZkdZZklTdDJ4?=
 =?utf-8?B?eE90TGVRWXNDV0FnYWtzdDBhUS93amVHZkp0SStIcVdkcnZneSs0OGM5UXZa?=
 =?utf-8?B?TUJ2NzAxZkpnakVoSGVkbkRPbzF0c25XQ0JBWmRRWFBtU0FjWDRIczIwQzQw?=
 =?utf-8?B?VXZRNVRPS0xnRU1zK1FDdU9lNFpZdnBCM1BnWG1na2YxSm01SnYxeTRxOEdv?=
 =?utf-8?B?UHFlVEhsQTNsUkhDaFR2WjRYSlJRdnBvTTNjQ2RyZWVYc3IyU0pYNUx6ZjMw?=
 =?utf-8?B?bDg3dFB6NUV2TlZpdmdRYmJhL0l1UjVaOGh2cU14ckdibExDbTBEYWVBRFlH?=
 =?utf-8?B?V1BJNUNnNUdDNzdMcWRyZGRyNmRMb1hlOE0rdXhoV3NQaW9SNEt6Q2l4M1ZN?=
 =?utf-8?B?cGhtdDY2ZVpOaUxNRmZEZC9SMWRSQWxpRTFyVXZ4RGtLaUZLSThyMmtQcE5h?=
 =?utf-8?B?c0Zoa1l4VHZhYjA3ZjQ1KzhaRXZyUnBLMFlsNWQvN2dyMUJiRkoyR3Frdkcv?=
 =?utf-8?B?N0FDQmxkdGtvUUQ1WGtHWFNvWit2Z3dFVVphNnZVN2JqelJta2VoRHFlaFhh?=
 =?utf-8?B?Q2M0a0dmYlZsdFoza3prbDU2bHN3WnFPYTd6dnpkMDBFRDJMcnFEQkhTVmhu?=
 =?utf-8?B?UUdPTUU3YlNvSVJrZ2NwM0h1azJvQlZvbXY5SEJxOTFReTdheUdxd3ZWMm9T?=
 =?utf-8?B?MWgzbGFzQkJlNWRLd0s0YVk3NittVHRVQzN4ZUlqZkRBRGxQdnVlKzE1K05L?=
 =?utf-8?B?OHpDR3VuSkNtc1g0RXlVYlF5OExJVW5OK21TRHdLaXF0NkNFeXVYZ2EwN3Vy?=
 =?utf-8?B?T2xmTFFsVEpQaU5DbFp4N0tLMnpDMWpyY08vbXM4STJ3dHdDd003cjk0eUFG?=
 =?utf-8?B?algyOVBJTEFTOTN3MXZqMHVwNnlJTXpRTEF4VmJ4M0c5bWFHY0tmb3FJSFE4?=
 =?utf-8?B?b1B1N3FudndCTUt4c01BVXNNL0l2WWlZVHFpT1FIQkdENUVyZ1VOWm9RNUg1?=
 =?utf-8?B?Wk82SXJGbTBrOWU1bXhvZmVjU3JQSzljclIxeFNlMzFqNlJnK09KMktSb3R0?=
 =?utf-8?B?MWQvQUFJNjIvdTUvZDh3Vm5uVGpTbXBWUURQN2FRYlg3VGZhWm5oNS9mUnZo?=
 =?utf-8?B?NlkxU3p3d2pWUnM1KytST0V4L1RTTXB4Wm5pQnBxZUVvNlRTQXR1NlF4MEVP?=
 =?utf-8?B?ODdyNitwUlBXQ29yVHArU05RSVMxNk1MUXd0QXVTVXZNajdkN3d5U2RwekRE?=
 =?utf-8?B?a2p6V2l6U0YreXkvMDJlYTNqbDloSHdVRnJOSTBHRzBsVTA3bnNuZ1pucVB5?=
 =?utf-8?B?T3FXWEtldXZXclJTbXQ1UW54MjJpZDdpeldOYi9oMi9aQ0RDTXV5VTlFSU13?=
 =?utf-8?B?Uk9TMG56V0F4emhoamlMYjFZZm4xeFh3emhMVTZPOHJTYi91ZFUzWE1velBq?=
 =?utf-8?B?R25vWFIrbDI2ZWJlNW1Bb1hyWGJsL1kxQmVCSzV0NGVudUxkdDMvMUhRLzhu?=
 =?utf-8?B?WEtkaHdqOUdsZ1RIWmQ3R1pxSDBVSUFUUDRlRExwYWlsKzVMTGJIVG5nQU1l?=
 =?utf-8?B?eE0vTmhET05VYmZXTkk1RnB3PT0=?=
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjA3MDFNQjEyMzE7NjoyUUJ4MWVVek9Uckt3cHlHNUZvc3I2STA5?=
 =?utf-8?B?anpXWFA3eXpRNmNjZkRTenc2ZGZsaXdkazdUTWoyQnhxUnpTTy9JNWlDYWZK?=
 =?utf-8?B?UVVrWE5JeFZQOWZzY3dTeEVjNmlRZFNEdEJ2Tld1N2pQZ2dVZTJLNDRudXc4?=
 =?utf-8?B?UlpnbDdRNm84OG5TK0doL3l4Ymk5cUE2Vy9NenNFZ09USjB3ajkvVXQvSTQ0?=
 =?utf-8?B?SG5DUlM1ckRkallEUGRFVFhqVnhUam5rK0Z6YS9TaU9jbGYzdHh0MVRINEZR?=
 =?utf-8?B?SEp6OXcxaXp0RDJkYlUvcVpxanVDaDlHN0lwYXM4SWIySjFGSXUzQXhKL3lI?=
 =?utf-8?B?Q3lFV2ZBWmxRUGg1TUVicGV4SzEvcGNXNEgrY2ZkdjZ2dlpZM3BwTkU5dGxQ?=
 =?utf-8?B?YjZ4VC81NVpkOWRaWVJRRENYVTQzc1VVTm5aT3E5V1A5S2xKUHFjQ3lPZzQr?=
 =?utf-8?B?SGZNZ1VUVkpVMkdsdStxRDBEQkNHWGFzTk16ZHBtUlRjMk1FV1BPUWw0U2wr?=
 =?utf-8?B?Z0hVUXlPbENNN01pOWh0emJJdDN5KzU0cEEwSGJXNmZmMU9jTGxoeGNFVmxO?=
 =?utf-8?B?SlVQM05zZDRQVDNMYmlMUHR3STFOUWZUcjYwNU1MeGQwVFZZdlNzWDRUL2VQ?=
 =?utf-8?B?SlU1bkRQR2l0UjdsUTYwLzdGS0g5djNDSExvMnhZR2FBaXE3UGRzdmIzenhF?=
 =?utf-8?B?OVBTcGM5MlgranVsa2x4SWVIeUY0MGk2MnZXR0V2aDdJbXl4MVlGNVhVVmlC?=
 =?utf-8?B?Yi9oczJPNytMUGNrdm12TWFjc3lCNDJIa2pKTGxDUU5KM095WTlyZUF4OWN3?=
 =?utf-8?B?NVJrZndpdVJYWmhrbmRIZDFaajRZaEJPdVJzSTByS1BzZHdOcER0bFVxeTUr?=
 =?utf-8?B?ME1ZYzY0Q0tvdWNKOGFlNUhBa0dMZE9BelhXcEREVEF6MzArNUxtVjZUUStl?=
 =?utf-8?B?SW1wRFBjTktBbjAyMDF0RzMrTEFLY29uUlFkSzFZMHZnRmNtNG1vMUZlSDhT?=
 =?utf-8?B?WFhhU1V2OGFCZWQvNml6NXNhR1IraXNQa3cxZjdhbU9jaXpyaVU5SVMzcERZ?=
 =?utf-8?B?THpHaFdwcFdwaHhyam9zMFEyVGR3REViK3dWaEN2ZVBubzVNWFc5ejBnOXdv?=
 =?utf-8?B?T0FUakZqYUpPWWVtcW1vdGpuaFVrVGZDb3gzUnIyVXVaKzZabDQ2VlEyZDVo?=
 =?utf-8?B?SXkwdXdsaHBZODhPWktNUEMzT09JNm9XalludHN4U0FXNEd4VUJLQklpUXln?=
 =?utf-8?B?SkFROEI3WUdLNlN5Z0JScmZPOWlzMTdaeFEzRzNEVHp1RG1zbGVwd1ByaVJV?=
 =?utf-8?Q?eC8pvph1DZw3/2eP3VPfqfcPK+Jv4bvDE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1231;5:m293wIfdABp9+3Ln1QCTL0XJZmsRprlAJ9hoQBTGC2Xhtwq7Sv6ng1QYfQji6Z9MpanPcUtdx/HSJCG7r0rA+c5iKPNPs3yA6hvZYut0o+Bkv3+tTh23Sq8kX7zoXegamclE0yH8TsHnT24VrqKdjsQ8u22wuvdiElhaMcQBp5O05S5qdK4E0k/9ccye+Ox/zpm449Ng/WfVXhsMZFrAXK28AHYXXDfvMhDWfqqUbyw7yQawmd6Dn+zaVFntxkSGIF179mj7b2+uiC1LVNrd0rtIqQCsjtw270uUAG09dreG9PXm533HpCveshC9Wp7KT4B/63G5XpT/AxPPJ/+RRbhYr1UEkN4Uuvi9VQjHCwOx44v4/LhZCYtiVSMiX4oaFg/9oWeFYOi6KnApe7LTGjVnFLWiOcqG7egZ/GYfzhIzaERU5D80N64DTwqI2ZdqxN2lfuz2mUthmsjwGzaNcIOKwdkGxm4n2DFyuPyhI9OpyOWgLxOoCJjSoNp4bGpI;24:j54QrPjoVSW1osoxsQo9AcIAYLiQcsQftRRfCnHpQMPX+LfyOaUmgVKs0XclHK0pRhhqixVOgL2jqfKqa8eukfMGo6RYAjEXklEtTN/amVE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1231;7:vWWS5QbdBQgHiI/ONrSiBUt3PGsPIugrCK5vfCtxXoqCaE4A+dKqIy/skuenKk9KnZ9bdB1pWqOF/ksAvxmFYGsDbcNJCORT4PKrk8Z3t8UMS2jBX8x6ZPRUoil/wbCC/ZSV03by255uyqYR7QooEpBhKR/V/4EahsQFul2TOaJ2EstWV14PDmi+CXc/6gSMW3+lajcBhrWbi64LdUCXc1No3pFPaWR2YdFaM7dQRmHQCB25+fbIoPNj0Nn4wXh5Zl3blDRZQrdjNx6zElL/EG+781UkuchcQP0OcTHi2XatZVh32GuGpvgNqtra6+k7tr69WXJbO+8m2aXj0cmyBic240h8i9eZ91BcctOtRjy5wnaATJ5sypgDCogDRs+pV/6E0k96qDpPqa9xUYyxrqVmq05z8VojtiiZf4o7QNcBF2v6hhGQVCrj+h+CvOtKrCYDqv/TkGqFIP+6B3hHZndG3bXzlKetWXzZpj71yF0FhTOsxwNDWLd6Z+tlO1AekDx/Jezx7mX125NykoMUvD+yoWZuHkbmgOj014yagm6E0Z3ZH2+uoINqkf5HZ4kAi0CiGcpxDOlyJVUjQ1Qj7NmgktObZ5s6NzHcYNVlPQbwxQcGMwrhHp7bpMVMNFCkzgE6RYzaM/UVUy/Tbb0lSw5Gi/m3sZMpMt5F9OqE+rnICtEpYDPjvZyeFYwOMe42Tzq+Lf+nkOEFs2Ox8rshA/OzoRyvCQRjLtumKQ7vlKeQdT0Kk3ahh0E/+nMHgR5CLGlmVOt2cbXj4HThj9XWtZuVKLkY6PTNSnWxpbX4ZWY=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2017 17:39:52.9942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0701MB1231
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

Fix build error when CONFIG_SMP is turned off:

CC [M]  arch/mips/cavium-octeon/octeon-usb.o
arch/mips/cavium-octeon/octeon-usb.c: In function
‘dwc3_octeon_device_init’:
arch/mips/cavium-octeon/octeon-usb.c:540:4: error: implicit declaration
of function ‘devm_iounmap’ [-Werror=implicit-function-declaration]
     devm_iounmap(&pdev->dev, base);

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Tested-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
 arch/mips/cavium-octeon/octeon-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
index 542be1c..bfdfaf3 100644
--- a/arch/mips/cavium-octeon/octeon-usb.c
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -13,9 +13,9 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/of_platform.h>
+#include <linux/io.h>
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-gpio-defs.h>
 
 /* USB Control Register */
 union cvm_usbdrd_uctl_ctl {
-- 
2.1.4
