Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 18:38:34 +0200 (CEST)
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:5901
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993888AbeGLQi1dxjxy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jul 2018 18:38:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHP0Ef5+v6gzNauJDU9WEV+5JOY7SZT8YYbnCFS8UDI=;
 b=iZTamh+CzVRSy9ITm0u4xHspokQV6Lf5QDUJGjl5dryOOPH6OwRHSwX2ySO1YnqtMNRQXrBOBaZJSQ4Z7s8c66hyFcs745VqG9rUVQffY+r0MEkXidmx/1WyUy9poZbabgRTp1W6BAyZ5P4VRSE2lD6UVF6HOL6EFU18WGj8pks=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4930.namprd08.prod.outlook.com (2603:10b6:408:28::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 16:38:17 +0000
Date:   Thu, 12 Jul 2018 09:38:12 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Rui Wang <rui.wang@windriver.com>
Cc:     ralf@linux-mips.org, jhogan@kernel.org, linux-mips@linux-mips.org
Subject: Re: pci_resource_to_user exports wrong region size on mips
Message-ID: <20180712163812.noq4igeyfffavv5w@pburton-laptop>
References: <4bcefc31-a62e-17ba-eb10-a3cd4e8bd06c@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bcefc31-a62e-17ba-eb10-a3cd4e8bd06c@windriver.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:301:4c::17) To BN7PR08MB4930.namprd08.prod.outlook.com
 (2603:10b6:408:28::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f6a2f4-dcf5-4452-ac88-08d5e815decb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4930;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;3:vRIHn/In3zWL7N4oMTGvI1sqkYXbrI23ckCniQzrx+EqFKvdQ0bIDmhyagR++4s1j5lbQVuic1NwqzVGbcEYE3T6KmOATlRDnPVGuLL/FfPsLjHt7YmlEYz5XknW85u85XiIaqQsD/hm7mMqHv2srLTKp2qYZnj7SNUtHwt6PlwyiF7Tk/1e1l15fCpZhNhh9ffRpUOzk8hjG4vCApfB1x5gOzz/Iz4bt/Bh1wf7MSG8vfSwjp99hvf1/h7xnLJW;25:2NprHT/iKje0x0PlxRRQKpbSMw1xfWueYcRqfone8y34TpK41Koe5W4sl2Kyh7AyYfOlBTz+TkOOEJMiF4JKOQ82MctCwTXj+2d1WWaR51eE8B+P/zzodgW+uMCx0Q8xNsTtZTV9G1e+PzNYnECaHuKCDqn4yUXA0PNd6FaQtzUzevEa7sTDsJ2cquBpbJibH7zADXh7n10uU0j55Xs36N0LMe43+pUwyXkrk8L2CmXyGObHpdh3AEWbWFQUBSLn+gU4+wPdEoZN8aVxltm9roPucv0lbpjZSfiM8x1hkvS407P5UWVedN0rSdy5OGZJ8RfrIP09sJnJ09h0/vjWqw==;31:613gtzpwzv5Hco/iKk3iqxM0JFHHV7vhukGihlA/Ossm126L9ZQJffOzg3hACyOLNFqwFBVfksUZ09L5JU+MIROpVoQF9Bavr1ZfpQ9z0M6RlelzUc0+01JW5yCcJY5SCNtcl5qk0Emk9CPYMWLwh0xEXA3v1XSl6iOD5eBl5kag0WJ6FG3peuQbnCI7+YxYpPCf+Qynw7gRE+TggxTXI5ThJ5XMnB63mQUGRrrQ9vM=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4930:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;20:f9Oa986OiYO4zsaJ6lsKXpDaM0novAxfVhY+zXQJNfmRDRG+vCdMC7OX2N5GbyMq6WWVGlcv3xlfT58FMUZBCkHc2PpRtGN7zTjcjN8bVO5oqP3VpCuIq9P4NyyLEVXejvHWfq2+99N3Ha+5JA1a9OH0T0g9r3LrEPIP4ALfsHvdb60ONwc1EFXAeiwslrEBzkvhLPGwVn2XJfrxDp5G6VZ46e5zBh8AW8E2Rhqt0omV/32a8FtK16ZNZb5uOQ9Z;4:CF97KFa4vZzjk0l+o5ZCuGanCrSz6jX7tk5VijZZJiJYM4mnlPRxQvn8FIXpvTSH1K5RmK3v0dVgJfHfluzOjy2t5zy+s5h9gkHwC5diADn2n1VLMN6F2yqpRdf6cCTrUPlgTgcLmG4PsC0ONbgdn2RQvCCbfeEW1VUgyAUukjMxz9mweqmHAcFRW0TpYRkQ6tVpTdW+kdI16D4UtKmtKeXnYDCpyghk4iV87uNEPTje9UKCryOgxV/f4OM2gMI0506Vd/G1LyQBLaOhFmLpiblsuZKetcFJ2peD+gqh6bkQhAVdKD8O0cnbVE7cYxgJDKkitvx22EFQiEHWJz0B+w==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4930E77BEDA79049696CE53FC1590@BN7PR08MB4930.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4930;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4930;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(136003)(346002)(39850400004)(366004)(396003)(199004)(189003)(11346002)(6306002)(956004)(6486002)(5660300001)(6916009)(486006)(476003)(8676002)(9686003)(6246003)(8936002)(81166006)(81156014)(44832011)(50466002)(68736007)(25786009)(6666003)(97736004)(229853002)(47776003)(4326008)(66066001)(478600001)(52116002)(106356001)(76506005)(105586002)(3846002)(186003)(966005)(1076002)(6496006)(76176011)(7736002)(33896004)(316002)(53936002)(33716001)(386003)(6116002)(16526019)(2870700001)(42882007)(2906002)(58126008)(446003)(26005)(23756003)(305945005)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4930;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN7PR08MB4930;23:t63jU9JwFA1MsgvUOUTsj5FExS6CaB8WRqaDEIO?=
 =?iso-8859-1?Q?ezFkKuPEfI8mon7LgBbeWbSTLqwK7wDLz1wr2Q7wAzkYMw9Roy83mRPyv2?=
 =?iso-8859-1?Q?ygw3XlZVVId8OJUCa1Y7dr8JSx/jvKpJTJzlLdewwFT5a5IYRvsD9+sm77?=
 =?iso-8859-1?Q?UDhBdg0wdDAF+sZZoWPLb9GjzMLH8IIHmgBkPzDaxXu1N8DiJEsHWITdJo?=
 =?iso-8859-1?Q?SwDomkZfu4jzliMZFiAGzVaqJ0+zz0xwjpmf3RnZ9b0tVn9Cv3lGSfG/rc?=
 =?iso-8859-1?Q?7rBXx1+2VKD5fU+b+ca5lmonbpipH3TrJIAo6CsCnQTXYMRncKGIISD77N?=
 =?iso-8859-1?Q?q2iqNkziXcV9HA5uNaqJ/E/oCV/XrbP5VBUVLV7l9AcSI3EK+4P2K3Yk5x?=
 =?iso-8859-1?Q?IfSAsAy4Nx8PWjT5Ti/f7wgw3/W7So2Z1GpweDKNX6ccRWTbytXU29u9uo?=
 =?iso-8859-1?Q?pVuRmh5lfrQ0nG2fWtd6XVx/nTD2JwipqkH90WxgwYzdbs1bs5ThSYGaF4?=
 =?iso-8859-1?Q?+86Z4MLmk0l023MEdwxUGBk2USuwSj2koYVwuPc4kJu2ILn2+ZaKZqG8XS?=
 =?iso-8859-1?Q?tHrR+rA+DnDCaH67NzorwrzjR4eKfc4UyhUrc1HcJM+QLbs3E9WNjqz0xb?=
 =?iso-8859-1?Q?YQRShvIonz7hvwkNTRnqnt44oqC0y/j2rhjcbqvlw+q5fwDFq6j3Oillqt?=
 =?iso-8859-1?Q?gj45TQOXrbu34oXvPk8xA32oDtT5p+83hWC/trFo4oQNPjhhhiZQQmoI/I?=
 =?iso-8859-1?Q?aAlrli2DZJqcOU1iaEOkx87VIDnkMyARib3VGLF4VG47NJRfIB4QvjcH72?=
 =?iso-8859-1?Q?2JOLIJ7ZC3zntLqqD4uu93G/bY9x8pu62Yt2U53OhSR5VMMT8PNrCN5k86?=
 =?iso-8859-1?Q?tp/r7G5mY/sAjBhA9NX4y+zbW1C4kAKtfdT2V8xIc+AaB3qn57HEkgPsG1?=
 =?iso-8859-1?Q?Fd+sArWg9RtjhpyTwcfUkwD//bnA4jrMG2RoNQsxN2VCqAt+VYSjkB1XYa?=
 =?iso-8859-1?Q?io+h88GteiQcCCq0bnMYD7hUCmPDzLznN9elKlTPGLTOTGcYX0QZO2XzPI?=
 =?iso-8859-1?Q?Mmh05Li2phg4tmX+X4Zmp/4pujUe2O3cdnbZ7ga166W5HS1Ghg3J8kK+13?=
 =?iso-8859-1?Q?ksLwQ8m6eqbz2YUhZj0CfdHM3Aq0Bmmk3x8/kuOAFotwArCiuigF1wmVMu?=
 =?iso-8859-1?Q?ixJZt1V7q8Q6K+zBY88kXw1NCdqV8lkHxEScyZ59zUPu4AtnQnxBJJ5whH?=
 =?iso-8859-1?Q?AGGl4B4/1dTFhSz2+yV1ITziyy5FutWjvK/eKy28n1wMT1utj2+iU+uDjI?=
 =?iso-8859-1?Q?KXAobSKIoWZebjEBYpl/PQxLRt3YGUfSXl1sld3N04e3FcHg5mF7HkIZHX?=
 =?iso-8859-1?Q?p9oGASrGIMf2a3o8/aYi942XFFaCmlrRKTO2C7N9S6B4+tzAW0w=3D=3D?=
X-Microsoft-Antispam-Message-Info: Isnj/miKYT6LprkUC9em71TP6I4k3vM/w8HnPzjc5g0x4ZL8FX+YYGBZQSjq3dBJc3sVEup9xJDDVCGVctsm7vxOg0e5D0Nu43QWKfv6twKlae+aU0CAAZz8/YPy1r5LBF0X8i8+Z+r5fCf0PcIbxkpA+4DHjUETvepZoNY0bM05OLl8j6vGPzomwGq1IdMi/jz4ZQTw/YlTJa949BZ2VIUVIPa3468PzJUHFzI8HkzoHOAJO7ZTg+3PKnWcyYARbluJpzyTi/YHnnulKQYMSw54jHDcOnUXDWMt1aV122ANlhh8gb3c52U4aOctYVUICG+DlqBFKGqv7r+HGRlrBpZ80PyW6uGEp79JwYfRD0Q=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;6:Vz4ulwTHlIYDKq1QktaIVOlDNy6xH3s8dk/gipLbfE4ycARHuqxIcV8wqtgQnUOzd8kpW9wz98lsARpYAlcUZ9gQsAwcCr5qGCdhXLKGir18FlBX+gqdfqMJHmuvrNrLlywjZ7XcJq77tGeMpMK+w+tSbXak2bVcbUKbFJTSJPcRErqb0jpqnudlnWyJfqXujCW7zCwrYDGPXRT3jts2b7LvWlNAvZOgF7sVDfyJubP9AzsQwRZjRsSBcM8F/G5ZwQ8Vc1P4rF1ErBxGrU7PlF0+rffGg/2277cv2P0zbnEiiJB4xAN5RveiNOD17HrXTpoK6PupbJaHurcScX0lGNfpdhWDqnR/ZNJd+aHVUGrGknC79xMsQQZtjxd6hj1pjTnc1qQ4gLN40tiJhEhyEr2hBNGFwyS5kvA5UJkBVTCHy3/ZOalDlpFZerAcZNpsVOBW0LLMBjzJCAC5VCNJTA==;5:sp3fkr2KVqGmda6tplFqDfZ85QiOKJtmMW4mbL2eCaY1ncIJqlJ/K++W3QSIFuEqeza//2+r8PYD9mhowiC6dqcw/5KgzoIUwWPQCWcQ80LEUqRXujINp/uBGIV3Kep0p+bkSeIM3OAuf3HbU968RjV8nSAdWct7N4pAbYzfXsw=;24:78SDs0nr0gAMwhoaJAWU/UrKlnV1p99yyEPiJU2ravLlG/H+nPRKkYjGIPYqFio+DB5eVC4ktQ8B9XpY9hSDNOTxPHOCc6BQzV/sLUxOoXQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;7:qUpnlOhofwnaDUn8xk2kvxDQt702uRLX2RkiD3+FQGVOca42yt+eKbKJEO1YFHwYPVR4STDISVki7bk04ntqEpOj6RTpXuniLdY88W73DTQMg0ss0LIo1eGDtA+waGDnhJcfzVSx41UNqfiRWlYiB1TlU1k9A1LHssPr9AdGqCR2Y7JTR6CpJrkNyuer4p6jbjL6B+pSf+HJtiRXY8VLLpBAwXSdGIqC+wfBKsEnvSg0S+yIjJpNVTU6dSipPWXG
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 16:38:17.0140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f6a2f4-dcf5-4452-ac88-08d5e815decb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4930
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64820
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

Hi Rui,

On Wed, Jul 11, 2018 at 11:25:06AM +0800, Rui Wang wrote:
> static inline resource_size_t resource_size(const struct resource *res)
> {
>     return res->end - res->start + 1;
> }
> 
> static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
>         const struct resource *rsrc, resource_size_t *start,
>         resource_size_t *end)
> {
>     phys_addr_t size = resource_size(rsrc);
> 
>     *start = fixup_bigphys_addr(rsrc->start, size);
>     *end = rsrc->start + size;
> }
> 
> ----------------------------------------------------------------------------------
> 
> In that function, the "size" is set to "end - start + 1", this is all right.
> And "start" is actually set to "rsrc->start".
> 
> What confused me is that the "end" is set to "start + size".
> 
> If we replace the "size" to "end - start + 1", then the "end" is actually
> set to "start + end - start + 1", which is "end + 1".
> 
> I think this is the reason why the region size is 33 rather then 32.
> 
> I have checked the latest kernel, but the code is still like that. Is this a
> feature I don not understand or just a bug.

This looks like a bug introduced along with the MIPS implementation of
pci_resource_to_user() in Linux v3.12.

The "end" of a resource is the last byte it covers, but what this
function is incorrectly reporting to userland is the first byte after
the end of the resource.

The fix is simply to subtract one from what we assign to *end here. I've
submitted a fix for this just now, if I could have your Tested-by that
would be great:

    https://marc.info/?l=linux-mips&m=153141325813771&w=2

    https://patchwork.linux-mips.org/patch/19829/

Thanks,
    Paul
