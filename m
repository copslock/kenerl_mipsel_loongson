Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2017 10:14:42 +0200 (CEST)
Received: from mail-co1nam03on0069.outbound.protection.outlook.com ([104.47.40.69]:59168
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990644AbdFUIOegAnk0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jun 2017 10:14:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mscc365.onmicrosoft.com; s=selector1-microsemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SqeBwcql8p7cYMQYBS4M0V388dA2DwSFDkbG1brdu8s=;
 b=d5mPeOoQLf/TA7rQy5E8ImMBp3r1auhpG94gCmdUxGdErShxLUSrOe9DOmwbAy+3Ee8gk7PN8Eno/jrFXMzRvo4nljk0SnFdxIaXUF2l2tVwWWBPq3abYAgmPxF6lxpS5LtLatyVcJMVI1k9y15whLr4fX7HvQDGHxJJN/U8rkw=
Received: from MWHPR02CA0053.namprd02.prod.outlook.com (10.164.133.42) by
 BN6PR02MB2532.namprd02.prod.outlook.com (10.173.142.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1199.15; Wed, 21 Jun 2017 08:14:26 +0000
Received: from BN1AFFO11FD007.protection.gbl (2a01:111:f400:7c10::141) by
 MWHPR02CA0053.outlook.office365.com (2603:10b6:301:60::42) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1178.14 via
 Frontend Transport; Wed, 21 Jun 2017 08:14:25 +0000
Authentication-Results: spf=neutral (sender IP is 208.19.100.21)
 smtp.mailfrom=microsemi.com; linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none
 header.from=microsemi.com;
Received-SPF: Neutral (protection.outlook.com: 208.19.100.21 is neither
 permitted nor denied by domain of microsemi.com)
Received: from avsrvexchhts1.microsemi.net (208.19.100.21) by
 BN1AFFO11FD007.mail.protection.outlook.com (10.58.52.67) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.1178.14 via Frontend Transport; Wed, 21 Jun 2017 08:14:24 +0000
Received: from AVSRVEXCHMBX1.microsemi.net ([fe80::950f:17ba:a56d:40e6]) by
 avsrvexchhts1.microsemi.net ([::1]) with mapi id 14.03.0351.000; Wed, 21 Jun
 2017 01:14:23 -0700
From:   Rene Nielsen <rene.nielsen@microsemi.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: clock_gettime() may return timestamps out of order
Thread-Topic: clock_gettime() may return timestamps out of order
Thread-Index: AdLqZk/zZ9/OsV2LQt+Nh9z9S3yvrA==
Date:   Wed, 21 Jun 2017 08:14:22 +0000
Message-ID: <478589358072764BA7A23B82543788A895AD4ECE@avsrvexchmbx1.microsemi.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.100.34.10]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:208.19.100.21;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(39410400002)(39400400002)(39850400002)(39860400002)(39840400002)(39450400003)(2980300002)(45984002)(199003)(189002)(9170700003)(356003)(305945005)(55846006)(6116002)(102836003)(3846002)(2501003)(8746002)(104016004)(5250100002)(8936002)(86362001)(478600001)(47776003)(110136004)(9686003)(33656002)(8676002)(81166006)(2920100001)(50466002)(2900100001)(23756003)(50986999)(54356999)(6916009)(5640700003)(7696004)(189998001)(38730400002)(53936002)(53416004)(5660300001)(106466001)(7736002)(105586002)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2532;H:avsrvexchhts1.microsemi.net;FPR:;SPF:Neutral;MLV:sfv;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD007;1:raeDL9GnBXy7GrF2lJdC0b51KvvdXdcg58HmJP9KNev/TFKPnwt46fgXwZoMg3YR3bHOF2NamK5dmZxTSZqvTOG4wHiYHLgffko9cKgDpc3iMigzk/3FPswBklgmfGFAuSfpUyKyGO/gD+MPCuJ7IeWtAWjnG+6QODePrfpbYvH6E6WpQYi0XIyf2YNCLwmApU+nvdP57lcinTzv/9+NvvXWhvlI9ovzZ06R1uqD//uTcfnlP9l2ajtgDEPRtjMNtEJOOeXoByQRAJVDrBNPA5O9dKzV5mXi+OH83ivGINh1VW8vGTmjH4z7Jnad+CJDhgCnpQmwye3VmaFGXmrdznSeXZ6HpTzcZLL2E8jbAV/mUwVIwaI0PDBJvv2zmfoaDQGVUDgcLpusuJymliXNQTuPXJYpW7xKINom4RkeoeitktDsd1gvXoyyq7FOFePzEB/RYdKTi6aB5uJXV9CY8VRNo6d0dVbHAnfUJ51zLoBHZSfBp4GKTiMCsCHJ5h9rnG98cjdxYpjEbabK/TpjF2smVSHqfZxcnRXFRnCQsT0TDdet14IdaSXSckMnfcrDwTm5FfzFUc4vyqFkuX0Q1Wvh6iP/A1RUi83hD57M8xYxqEvp+SYXfY1rkm9UaBDsPxbU6MvsUjQexhKzUMmzuGT6STNGj8+w/IzhzKJbWmUOrSkIa6qKPFSDyLGtEJZNYnyeNldPpv9EGPEFT0IpO/UYFKacCpiR/PAMbYTTAVNQR3o8pKEpGG1o2+y+gK3OXhas0P7guEEr93fPNsBQaQy8e0ta+iGynDluqcQmV+K5+Es4QSSiDL2nWD8o7Alerw1KFxOnfT/hLapFMVN7CG5pruXtY/pDNfQvCWabEAM=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae546468-ce29-4e16-0fc9-08d4b87d8790
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500055)(300135000095)(300000501055)(300135300095)(22001)(300000502055)(300135100095)(2017030254075)(300000503055)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504055)(300135200095)(300000505055)(300135600095);SRVR:BN6PR02MB2532;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2532;3:d3oKGRO16q8cpq21y9vkhfM8AQMiGVk8z0EIAHFZ5fjeQ0Tcenr5FIks1LvLXOQjW4eNrQ66iHqFI8J8B0NJlC6gm09Jp4WTm5pEGTiU807fO0GcRef1r2vT+qXat/51yBvIUdz2tPnsE8fhDTL/Uy5zXykn7TKDeFecLwDXP1tRgZy9XSBzOHJ+wbVm+AXOu4nI0gpNSmdG7+0ekq4B2x5JRtlkjirDxH4gKegUs/x5t+4bXNUWAPCjGJJJjNkoo1WxDCuBYa1V4jk1R7dNskHzGq3rN5IEcxSwQEEc5uLsrE9yny8fUCiR7UpT3jqjZVNaR4vzhjeIcrmvFSh8w9LTlixy7A2G5h51RkqEbcRK1ntzGKjBZ/YkIwnhxax7cbPks3a0eNvdyP9lJri0Hvo37HtIYNvz+Tkujg3nGiQlQFyL+BQ1TgBYCDTX+GOY/ISL2ECPoBewI6rvKyTK8g6eWFIa5K3DbcSosCtqlwdLFHEKjW7cErHWEsTR+j7JRAuIsa6LVTxF4iLE0EsD/Fs+88Y/tBnbe2/ARhibg595LkY+dIJH+AN1Xg1J8ZGT/hFHhU0r0gagSzvTd4G7UbjOREZBIsg2+ScN6d7vCm86xWGC/LW9fmeE9FVNw8npSQFi7HUBB9VJl8w4fBY4tk4CgrIcn0Id2Y/Rlkk83ajiqc0IfZDA24x7I1Apa6cUHP/UvvX+FZ2GMWhxNaSElE+ECXpMpuw0UDrfohd8iziIvziGNBuev2BAYCVGyPkrEjSdT1BJP/58hYd1qiACyqOctPRqKnrR0adOeLRMNib4o0NSdiDzRt4/XdGFKRzfd304tfAdDTOTpkdfMdyWTzqKhsWvQAz4rXKlgNxH/9U=
X-MS-TrafficTypeDiagnostic: BN6PR02MB2532:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2532;25:LQpj8XIXzCx4E6YyFDLBKGr0oHauXIOeZXicxcSRAydEVl3gU+phQbzJ1HN/qRSkX1JSwbj0wfoYkL3LCoEyGhrQ3NLVq6SNP4mKDU/KxemDamF7/t74lFYH50nQxTwa0SqFi+jSFdtAfNwBr1zpi6aLkRDW5k2UApGhXmJB6zQIrthg/UOOLmujx1SeFAMOh4NyOnMdL4CGQU/CWdKsujBcwiOrGngQXE8VIxpYHqg7XiMnPcCXt0eYsHviP1W5+6CmaItVmS9tcd+2bK+utqUtkJ7aolRTB28GkV2UbGVBAwzkxHf+VHjgEb8CUA+uhjCbDq0agiCytarmclVU6wXRB9lRAtHrrjgnejMsEt6Hz5PhpokOATFJcBtIJpgwXf+eX82V3+rjz4mMhrDEua1AKpksTJ0wKUJ6LVgXL1iGMkJi9xOZosFXaBNmp7W5stylNWKVVhm8SrIVg0VoIDEWQrjdtKH4XyQly6QmFZ0S9EKQHV/LNhKwtHJQ1YMQ12XxfuVhjv8JDWRY6Lzt6DZ/sJxdo04ZW+b3T5tKtH16EFFt1f8NpCyZU5zqehFIdk40Q9oqHjug089uW2+CQ1nKhQ6nU4Uu0y5v0ekES5vgAZpFMm0ovHi2IcGS3rEfixVrALKKVm4kkB8+bGf6kePdQCkLDAaU2D9DzqcivzVh9R4mzraClQLpgmJ/4M1XOtm3m3wOLmErQ4iMew151vVAOVofulZWvsuccYykd2/R8vKTIqgy1QfqcMn+8mdnv3UxIfum6hCgheDW+kQAC216unQwx5fX7HvQvhQVX7GcnkZhnkUlqfFvtuJbeti5yKosBg/QUUuPzSiYYIGwJr3bRUQYbIT4q8+9xHwQILFsbDXClx/0gGJVl51K9cGWZigT4eCdeQJkQn1U0Xnphc4cTVKU7DkEVGt59OgXGm0=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2532;31:v90BTzeU834UG9+ZscaJ5xZisTgBm1NC4LGeEhB1H+nTKcUS7UbQxeIUJzHa1ga8cgT2iHKBvANg/5bNiQu9NmY4S2H89T/34y8+TF8RV5SeFfiYjsd6LmM5EO2cpTDPIAgph5YUZMFWXvB1dc7rQXM3D6g7OoILxhZjXzat183twSZY8Xptp6R2k+7wv9AV19RAl4QjY18l7zQiwwNSRNwzHg8GsTKSWuZNOVNAH/GC6SV3QEJXalSeEv189OjFhcc4Js/dXWJYESdX1RUs45F2PdH3bpp2zKW1MEPX7c53JWQ55sftfcChA/2Igv+8gO3KAz40T9mv0XzlasNjpL0t1wnvPABEeS/24Gv8fbANt1plWHK0NifyWkpHAvy7TBAxyMXJnDTWSgwreMeYbm5HdysJhhQhvAFf+PpuYidllBrgIIw1k4NIi5fDrZqTkWMEQNsnKeC0PSY2h8QqxxuUz/ZkscycNnF3sHitEc31FyV5Fxc9o5LpuhDjq7q+XfT8YRALrepJ+Pxgxgba4oSzk9vepHEreqHvlqQgXAoQdaGmLQ+nTwyut++DQ/wJBWNn2KPtbdKNeQEjs/HMlNSsptYUJlEwsifew3T+coI7wU8j6h+oGWrXmjddPp+galUzt70hNsn3qvjJS+xXkiR64Q8P5AxFzd0NBX6HfPxrGnzh/bgs/cB2L3UYDVxNdKEuFDRJ5TRiS6K96ivoIA==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2532;20:L0q99QitzpfgRWahjevBC38GNwyGj/v1hCr3GuKzLQ00GlsAW8cah1Stvtv62deA5Q3McqKdqiWLcuz8Csq85rBLkv7eskeeEwU6KiuDswxrBSZhmpMExc9711k/ap0KwIgvpyTzeZv+K7u2jeDD98xxf5FW52LT7hjOJNb5Imor8RLWMplX1kr9eWVuuqcpm8YSMLEPGLF+vFmYv+LpIjIRhSsnh7o1APtQ1zQbVVKqmzpX5eEAV3m8lzMvn0JbRwNzNq5PvU2gK6xqGV4n+dNKIYJK1U4dy73UYNAeo+AavsYYztQYfswLOy9Y0IMGqeK3czej/PE3QHoyzkiMvISJb3dXQeQVZ8PF6qBf+Z2PA/gE+9G1ZCYMtaz3er9yx9Hu0L0ec9g+1FrsZPwCD+NXBmO49izU9EQq4m4KCP90kzvdtDR9E00iPUXfj+ydG940dU8Z502QcZ2zH931loWklT1CmJbg9I8kQ9KO9fdg0d9V+DZtZksnv3+435rz
X-Microsoft-Antispam-PRVS: <BN6PR02MB2532FBA01B4FDF7AB64767B599DA0@BN6PR02MB2532.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(13016025)(13018025)(10201501046)(3002001)(100000703101)(100105400095)(93006095)(93001095)(6055026)(6041248)(20161123562025)(20161123555025)(20161123560025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR02MB2532;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR02MB2532;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN6PR02MB2532;4:VQDVSNqQBk3yv0jTfxz375Y5yv+MfXvQ8XyTaouH?=
 =?iso-8859-1?Q?GeWAM7v64cj9Dg5npdLmh1xC2g0y+bXEmBMCcXQIGnblwabPmy1XRP7gs3?=
 =?iso-8859-1?Q?3hhHJBwG+AzTkXo/urjYyuErQSCOtnIBD2vLITqM/NjNiGtFCOi59tnk3Z?=
 =?iso-8859-1?Q?NT3glnvk7O61l25JA6I1tjHXVG5ivsMHXLBhf6tXNvtZNtd9VtmN7wuGDa?=
 =?iso-8859-1?Q?71V//UuUCuejWHvtj0ulbcju9ZSOVgtzwmkmjtE0+GOrftltbkiDApyusv?=
 =?iso-8859-1?Q?J2fLD1kXCcJj9Y3e1zBT24VxNzUIBuKxjMaMSIjSkUjDDL50mInHWyyIqx?=
 =?iso-8859-1?Q?XHqV5u9ogzFGvpXJjECx4cnOYXr2fM8DSmNFhHw/ffdDDkpoIdvCT0qt7M?=
 =?iso-8859-1?Q?A9FGJQz+u/2lpzXwceqTr1CmeJ4C+Rtwko04AcfI3RY1q/POHzDwGm7YlI?=
 =?iso-8859-1?Q?zZ3srOQoH/zGZtFycmYTU3qVzoiIjfKFcPo8WEokZV/q6nFajUwIhkNpfR?=
 =?iso-8859-1?Q?9KX7fJM3RfJCZUb7OJYL5w7nz3NX7zx8Y3j2CZc8MAxxdnUpzPyttEODOL?=
 =?iso-8859-1?Q?bo7NFHREHm+7taVT0LCH+StByXfT6ZnBdaMGdRN5BcrV1IFe8aChAx2IQg?=
 =?iso-8859-1?Q?y/4yhbj1pgOp/xzoy8+onszPzbtf05QH8VgRfqqfhx9G/PJc0YUX2wIKLr?=
 =?iso-8859-1?Q?oWUf9XxukfAWUT6cQ2HGoOcSpSZpHTkOsQhmPATAY1EeIPZa4aG2hQn8LV?=
 =?iso-8859-1?Q?VkDoKevZ4hyZTLSmOPBarGLXBkLTKmLtmZyVtbOM5xsIPkvJqwnZ+wO37U?=
 =?iso-8859-1?Q?sYuwjDI8MQPWw8ZZFadajsfEbAWRJi4Cjie72WKhkAYN58Hv3v+7XSFzwC?=
 =?iso-8859-1?Q?+jxUV6o8fkonLI53/Ryz41yLQA5q0EpaVN7evxtD2xCgVOHfZkQcO3OUG0?=
 =?iso-8859-1?Q?uIZEH7sCyK9VMWi0MGOqlPc1m7AIqAmtiHc5v1JUsHzdtrk/5LmD/7gdg5?=
 =?iso-8859-1?Q?S4/F0/7YMFywLCZpy15eGL2RQmQwxMs7db9S2G/QxWnPnkUDNwU9LJf7JU?=
 =?iso-8859-1?Q?MdpxqmBFAarZaMTke1wJTVl3aWc79rHTSSnvjl4EAX+3guxPJZkEyqPgK0?=
 =?iso-8859-1?Q?G7wHkEMKoSYStU2V75EDexj/r5Ue7fOgW9cMqIWOYnSBPEshnxSQV/4TF3?=
 =?iso-8859-1?Q?H5n+LylzkRRA5uf9camar5cNtHqh5nVtgXtdpJiE1DkLbCade6zzKFyIuz?=
 =?iso-8859-1?Q?et3ZxRe4pU5t6SJR?=
X-Forefront-PRVS: 0345CFD558
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN6PR02MB2532;23:f8ftbUB8L2r0jyLq5+6lYfvCvjZD3GWJPJDgYFL?=
 =?iso-8859-1?Q?xQK4niNVIXnh+ewdSCzkRLsFn9/pgL9B6clDXr2RLeOmDJdpF1TNdf+qye?=
 =?iso-8859-1?Q?LIxsqVrWCDyQzVy202c67nBykfll4BiLu+lJhA7VDZsv0bBdH1lk+VR0wn?=
 =?iso-8859-1?Q?mrvX4Nu55qm5uagEXm1Zu0+txHCCDM0P0SS2A+ml9vFlQWarXpzlJnJnN1?=
 =?iso-8859-1?Q?z6e2DSI7D3FC2oLnF/TOaNByrWjNpr69rCyZvApPXkCW3rtS0ve9veghvt?=
 =?iso-8859-1?Q?2eFgabZorl6Vlp3hZ8ruWMFRBwHMgoyC3qZ9uDVACrdoWktmBCBzrdLcxY?=
 =?iso-8859-1?Q?Eq++r6VN4ZwRoJLJNZiCrvEHt9GT650mbYLSxMQWQEnUSrcTRFStH12Lue?=
 =?iso-8859-1?Q?CEk5bCQ1ShtSfAJl22X83dYsFEipG2ByfZqO20IUJHvvJdd1iYupceWtiN?=
 =?iso-8859-1?Q?O5z5E1wbsdMwmFqvs0EUsgXH6U2P/FiYioPi4OjJiXMOweIO4pT0QVoHiE?=
 =?iso-8859-1?Q?OoAQlX2CMsi1dW2qYX4AmYbv5u0IFP4gDfsD/Zxw/ApI+qKowMJ1ygL3ou?=
 =?iso-8859-1?Q?a5tv+T9Wk7CpyfGtzJaFxtwKYJEeFREDr3baA+HIbOocsls3nZCoqDGrye?=
 =?iso-8859-1?Q?UfZ+DIoMQYFb9J5uP0TEasoU0/MWKr15TiKQte5PGeX8zsb9OIGa5VMTfT?=
 =?iso-8859-1?Q?FXaF0iIat1iqRBsR7hBGPc6/puoF3fS8OPgrXdk1Q5lInkH85FaaByqZzr?=
 =?iso-8859-1?Q?ItBiHRDyFYYWAmpmcC7V7jY3BHp2SgAiLrvP7MjwS1D20V5piElPURa3C3?=
 =?iso-8859-1?Q?0xwIvJCXrelMa51871s9bIp4Zmgq/wMUy7SHoZOWFw0K2HUId2Fl4YhpY5?=
 =?iso-8859-1?Q?OZBgeNszwsMyMJbR7fQLjR+jValpzZeHBhGpDoMy6bBtURvC8BFkkMxPNg?=
 =?iso-8859-1?Q?tzgauTYCUQARwG8GzWZWSy6xx2oVo/FM3hWh/DxFyxv5GOFtDYcavRy3M/?=
 =?iso-8859-1?Q?oRffEhNIJGqDcMep8CHq7AD98RTv28INhpK57BFK9bs22kWjj+bLqolbGQ?=
 =?iso-8859-1?Q?+YyIhztQGecDlIrtHPXK+wBsyaDhxp0SDeLhbp8tXkcNlgvoWQAqQXGSFS?=
 =?iso-8859-1?Q?c7D2fCRt0tW8h2NtWnD/4PI8IbmSfTyXT/FKTre9YGmYFjx1cFlBC/7qSV?=
 =?iso-8859-1?Q?68Ahnpn7P8qpXg4Q2PbJtD/2TuYWuCVJBirWebl+iSrJEge5Zeky/qGzq0?=
 =?iso-8859-1?Q?Z9q6vWYtvtLqhjr4n?=
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN6PR02MB2532;6:7tzxkonwUvD7Tj23t+ElVef2/2YrlleS9Njyg0OW?=
 =?iso-8859-1?Q?cAdT/JxZ43Rz2GpWp0TIY/dc+w6myOSmVvSJWNWf5peAxsBpQBYTCQnP/k?=
 =?iso-8859-1?Q?4APDbmLuiOzGhiKLOEL2IvLgbHREG2CeCMzmh8daAcE0l9pPBttsIO0SHn?=
 =?iso-8859-1?Q?34itFyFhEDA+AvpDYpkL6yduTo6scw+vZkxhoXBXFxJn+aqUIFhMnHOZD4?=
 =?iso-8859-1?Q?bQbvbBa+XNE9Y4dWUK4X0rr2K5e4O+iWyQI3+pJy8Yq7TYkz1jK5Bu4Q5W?=
 =?iso-8859-1?Q?6ti4Y3rzQJ6OyG8l72qNK9HT1CrNrR90MQslp/60O7Jz/9HGHmIMG+Fyd4?=
 =?iso-8859-1?Q?Z5GwmBc9EQd6+DLdU1mfHmmsDKgKhGRccaVli76xOaytmHWd4nIGAO2yJM?=
 =?iso-8859-1?Q?BIU+GVqIOx+JQg4znjkJZ+evtmlj01z0S6yuntAwEOx6qWR1F+VtslYKPc?=
 =?iso-8859-1?Q?zbk0wfRm0Va5RswOWhsyoRXiKZs7Y2xSicVU7nYrmkePaA9x3qZomksH47?=
 =?iso-8859-1?Q?BsJakjMgyWTh9RRdxYjfTzkf3bJgLVMD2TPSeQFalwpiVepPuWzxOVvzND?=
 =?iso-8859-1?Q?xTLudNCtBDBsINnevPNn8CvvRz+zaitNY8mciWU/0Qic81FTuMB3LaOLn1?=
 =?iso-8859-1?Q?iJJj8Y2I88+l031wG3FvMDXwMgoDx9H8ZSPdZgMPOAOUplHA1FcKqMNNGD?=
 =?iso-8859-1?Q?rX/QC4VXeBcsL/PuG3aR3/3ZqFfiyhYMXp+gTiidwUnJl5onDT9UUYufuC?=
 =?iso-8859-1?Q?3REqwMY5B+1+9X0n08Jvx6zYebSPdubgTScph2dcCCqeiMiFrbl1EGI0VH?=
 =?iso-8859-1?Q?QEGRZvEYE8QXXWYfutWsLuT9X7Aa6tAkQ1runuyIHlrF8OQ9+v2miJIk+s?=
 =?iso-8859-1?Q?ffTK3yYaKICLmU0tOxuTnXr5aGQHr3MWF6loVgicaNbgdE9Vuzxlbnz5f9?=
 =?iso-8859-1?Q?GLxLPWEuhzD0BXHLLUBHaa2D8eW95qWO/F9qYaNeAS96r7lW+oTh/WCQbY?=
 =?iso-8859-1?Q?kGyAvfj6DVBykGQHLeNrqSbJkUJGp6GsH/WVcE3HH8CQJGYFz9Bi43Wu?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2532;5:fIroJyijj8w0DQm4Sgzk/T0hctPsf+7R0ocTq+9LSAdBN1exbSehMgxHIBV0g9KCtA3AAEry/cY1vJFIyjk4+tItirYwNg0jQS/Kn29hGnXNso5TTSNUyQfiHXaAoKSx0jTALtoRhXSSTjpI7LuCknPSVzXvazzR6Euto1V+nJfcaKtduVBXH/C1avKPMqNchB+Ok6wzEL7V/Vg9Yvnj0SeBGaEP7LQ1Cp89VBYRbGqkESegcQP/J8nA0Itzd+hdc4bk8DbgD88x2sU0PoMqdi8c2Y49Y0CFRC4GzfLi/pQ4OW2jXkQdRJGeZbJYa+84pjBeRs03ART9hkJ5Uw1d4ROv/j5DHY0j+Kq9CDc6qGhMgRtF9XuVRTiTdKLiR6eVmoW1qysxDgtoq63j5lVkSLnf702X/lSBTlj2MIoVk2E/qFVmv10I2tFRNBfuCgkO061i0mzdfr4JNp61cHd6NDqlBbVPJpwi8An3g6QKwVjb7M/5bfyiU8q2zRCQmVoA;24:KAa+E50xhsi3ECXLi8fhjZMkCwdaJnJLJQL9ObkH8j2v7Y2A23RbMu4PmiofN4ptkbtcHsTSW5g3nypX3ZFrDkkLju4pSh3ECiFkck/u3uo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2532;7:mxk8abDIrBOX26gy95bWkpLII3igEBUuzAWscyf2rw6MAqVadizXbHtewuLtnZRwRyUhAKvPD67/6/7Qh2Q4m9Xd3yWtLYPyzSi1OMe4gNxu6Ag0mthzS+7o1A40jKNSfzZIwSvQ+TRRJV+xN5zvPV32S7Kr7StFNaR4Q2gfydz3Rjx725N8HlkmatDM1761WWFrjee8DAk58QSzNI/d2f1wFnptGSRPIhccvktPrSpiD9oy3NvPvhCLs+G9eZJ30wIbQnl5sOz1wYeQNCeGWkxR1DNzdoZSV1jDVnlW+C2QmyhORka+xXiMV9C9kgsreMua0E5KZV+uhosNOl4mlEqAUeKMKEDK9B5Z/YEatmKkP/KD/DdMSck/NcZ5+BM18YpWNZsooACCvNKKzlAxLeL+416rUj9Y+bHnX3mmQaCQ3WPdQ7fwqP8P9hFcOD/3Lreq5sKJQBwYRyE7dR5sAZnLE3jk4Tnhl+OMtaIhePF3kMDB0Djp4sEur+lMUhM09C+U9/ScROq9VhcSw+bLaqndrgaR0CW3OM3isq5Jp7Fv6URm45IJWAzOl0c2tNQ2C/3Qoogwg8GjfdqqISVfe7SU2WiqfKHMHSrjRvmVWdvkXqrVUjvPKbVAt58w2gv5VdSn/X8znbamJk70gRnKjC3h6I8+QGzUyOO3K3aE+Km0h8OuuZmJh+LnKSmsBiXnhyH2tu5OuHbsMzvCTnW1oOWuroL6RBsXZXBbYOOCNI03jVSTV7ouCZqR6DhxFpkIP9/wEBNO8UfHqKYzaykawKTBZi/FOVLq/UZ3HX89+gk=
X-OriginatorOrg: microsemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2017 08:14:24.7594
 (UTC)
X-MS-Exchange-CrossTenant-Id: f267a5c8-86d8-4cc9-af71-1fd2c67c8fad
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f267a5c8-86d8-4cc9-af71-1fd2c67c8fad;Ip=[208.19.100.21];Helo=[avsrvexchhts1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2532
Return-Path: <rene.nielsen@microsemi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rene.nielsen@microsemi.com
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

Hi folks,

Let me go straight into the problem:
We have a multi-threaded application that runs on a MIPS 24KEc using glibc v.
2.24 under kernel v. 4.9.29 both compiled with gcc v. 6.3.0.
Our 24KEc has a 4-way 32 KBytes dcache (and similar icache), so it's prone to cache
aliasing (don't know if this matters...).

We want to be able to do stack backtraces from a signal handler in case our
application makes a glibc call that results in an assert(). The stack
backtracing is made within the signal handler with calls to _Unwind_Backtrace().
With the default set of glibc compiler flags, we can't trace through signal
handlers. Not so long ago, we used uclibc rather than glibc, and experienced the
same problem, but we got it to work by enabling the
'-fasynchronous-unwind-tables' gcc flag during compilation of uclibc.
Using the same flag during compilation of glibc causes unexpected runtime
problems:

Many of the threads in our application call clock_gettime(CLOCK_MONOTONIC) many
times per second, so we greatly appreciate the existence and utilization of the
VDSO.

Occassionally, however, clock_gettime(CLOCK_MONOTONIC) returns timestamps out of
order on the same thread. It's not that the returned timestamps seem wrong (they
are mostly off by some hundred microseconds), but they simply appear out of
order.

Since glibc utilizes VDSO (and uclibc doesn't), my guess is that there's
something wrong in the interface between the two, but I can't figure out what.
Other glibc calls seem OK (I don't know whether there's a problem with the other
VDSO function, gettimeofday(), though). If not compiled with the infamous flag,
we don't see this problem.

I have tried with a single-threaded test-app, but haven't been able to
reproduce.

Any help is highly appreciated. Don't hesitate to asking questions, if needed.

Thank you very much in advance,
Best regards,
René Nielsen
