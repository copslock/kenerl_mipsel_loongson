Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 20:02:26 +0200 (CEST)
Received: from mail-co1nam05on070b.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe50::70b]:39376
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992514AbeFYSCUFbK4e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jun 2018 20:02:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXVildwr3r9UKmhd9jSCApZ2PAAx2CYQ256n8m/KPt4=;
 b=cV+EPfNLL2roAg47ay6lByKiQSS0cmT40j/IYMaxm8veyHeLfZGsUCQVcb79pVnHXICmkFWkFh0AhxkLvD/SOchVAUD1pjROzo2wbWUM0wRDGYERdJnFu9pg1tXGzSsd56QLqyvxbtG3RksQ5L5JW2oG/toYjfPCEao0JubXNAY=
Received: from CO2PR0801MB2151.namprd08.prod.outlook.com (10.166.215.6) by
 CO2PR0801MB664.namprd08.prod.outlook.com (10.141.247.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Mon, 25 Jun 2018 18:01:30 +0000
Received: from CO2PR0801MB2151.namprd08.prod.outlook.com
 ([fe80::4cb:25c9:7555:c4db]) by CO2PR0801MB2151.namprd08.prod.outlook.com
 ([fe80::4cb:25c9:7555:c4db%8]) with mapi id 15.20.0884.024; Mon, 25 Jun 2018
 18:01:29 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     Paul Burton <pburton@wavecomp.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] mips: rseq: Use new interface required to avoid SIGSEGV
 infinite recursion
Thread-Topic: [PATCH] mips: rseq: Use new interface required to avoid SIGSEGV
 infinite recursion
Thread-Index: AQHUDK3pg2fS+EA+5UygeFJcjAZEFqRxQyLm
Date:   Mon, 25 Jun 2018 18:01:29 +0000
Message-ID: <CO2PR0801MB2151677C4D88B4EA219AC88EA24A0@CO2PR0801MB2151.namprd08.prod.outlook.com>
References: <1529949379-5363-1-git-send-email-dzhu@wavecomp.com>
In-Reply-To: <1529949379-5363-1-git-send-email-dzhu@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR0801MB664;7:2oEQJopbCnG3T7ptfBYSB1JBNVpMMyLQ5iPaiNvbG8EQCnqFhcOGtBGXXdREnyagHCnzyo5uOc0bWlCRBc5a9g5SyCArux/mV8NYFZ1FNAGTrKOwEw66X5kV7pqWD7a8m13oa9kdlfi+VV8N5D+cJX1w6DlzNlVg888FJVp/7HaYOyARZwO+eXtUIxPHiQW/tVDm2J1AuV+N0gMyDXjwP+B5RfvoONwtqz/uwrgnZ/dC2CYzGlMdKv8IwwNW3Fae
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(39840400004)(396003)(376002)(346002)(136003)(199004)(189003)(8676002)(81166006)(81156014)(7696005)(6506007)(106356001)(102836004)(4326008)(33656002)(76176011)(53546011)(7736002)(2906002)(68736007)(478600001)(5250100002)(305945005)(99286004)(6436002)(8936002)(97736004)(5660300001)(25786009)(26005)(2501003)(9686003)(55016002)(186003)(54906003)(3846002)(14454004)(316002)(86362001)(229853002)(53936002)(6116002)(66066001)(446003)(11346002)(74316002)(105586002)(476003)(2900100001)(486006)(6246003)(110136005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB664;H:CO2PR0801MB2151.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: d75d23d9-df7d-465e-85b1-08d5dac5ad97
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0801MB664;
x-ms-traffictypediagnostic: CO2PR0801MB664:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
x-microsoft-antispam-prvs: <CO2PR0801MB66492840AEEF9E3C8197E07A24A0@CO2PR0801MB664.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CO2PR0801MB664;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB664;
x-forefront-prvs: 0714841678
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EDiB3hZvDqmY1TRx/1reec+lQMVRzJ69ZUREijOa5TQHwgNwsA5QgeA5JhErKzZ7Taqkcv1s5Zfydp2UWZHFahT4OGoVZURLvzjQg5grbaxZ6cbQ34Nqkt8++UAMAnUgbFmceRhYQe7vlzfiEYqhU2IPwQqCkmgSKEtVajMn+lV8aLzJ0Y/4HIImlL7G/xf1MAsVATeNaepmnNPYtdEV9hGMXuWnZyxSLYBvHpwnIeZu0yvIn7BjVm/VH/Cdyr1vW1O3yDztvnM8QNNZ7YT92VhKIGptNDhXLjgCdCPHsyJLPK1vuJ0c8DBWpGiTeoVB7YkgFKGON8ymoCxYUJU4+QZ825fPpgthH4YinhQSMac=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75d23d9-df7d-465e-85b1-08d5dac5ad97
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 18:01:29.6562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB664
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

Right after sending out this patch, I found Mathieu Desnoyers had already done it. Sorry for duplicating.


Dengcheng


From: Dengcheng Zhu
Sent: Monday, June 25, 2018 10:56 AM
To: Paul Burton; ralf@linux-mips.org
Cc: linux-mips@linux-mips.org; Dengcheng Zhu; Will Deacon
Subject: [PATCH] mips: rseq: Use new interface required to avoid SIGSEGV infinite recursion
  

The new interface was introduced in 784e0300fe (rseq: Avoid infinite
recursion when delivering SIGSEGV).

This patch makes the change for mips.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/mips/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 00f2535..0a9cfe7 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -801,7 +801,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
                 regs->regs[0] = 0;              /* Don't deal with this again.  */
         }
 
-       rseq_signal_deliver(regs);
+       rseq_signal_deliver(ksig, regs);
 
         if (sig_uses_siginfo(&ksig->ka, abi))
                 ret = abi->setup_rt_frame(vdso + abi->vdso->off_rt_sigreturn,
@@ -870,7 +870,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
         if (thread_info_flags & _TIF_NOTIFY_RESUME) {
                 clear_thread_flag(TIF_NOTIFY_RESUME);
                 tracehook_notify_resume(regs);
-               rseq_handle_notify_resume(regs);
+               rseq_handle_notify_resume(NULL, regs);
         }
 
         user_enter();
-- 
2.7.4

    
From sergei.shtylyov@cogentembedded.com Mon Jun 25 20:07:02 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 20:07:14 +0200 (CEST)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:51917
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992553AbeFYSHC3-Ane (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jun 2018 20:07:02 +0200
Received: by mail-wm0-x244.google.com with SMTP id w137-v6so4972684wmw.1
        for <linux-mips@linux-mips.org>; Mon, 25 Jun 2018 11:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L9/llshy6NEdvrwUOTlVO1RLZRowHloveuPVTU3VHOM=;
        b=zOx455WyRoBLD3+rcWeD6lDt0PifoDhG/syuTajt3T1eHhoK921Gz/R685+2FQgPGU
         Wi4tPLoBDWHfbgNcg06yjAyksZIXwYFve0gAJTcBfjDEI+/mRvLqyewlE6RTfpkDaVU1
         8HLudqhe6ZjQdWg3mk3LC+pdBIsoMzuZVgH0cUHzqbazcPE1IOBGJKew4QGXnEOGzNkS
         5dl3u1aet2/gYQ2hEdG7PKgThKOqDy6CYB+YqDbpcOAY84pabJMuAVfjc3oCdTnBzfQh
         ZZ0Exolmj+C1bcbM/6tzjQQVP8tptBfplUus4Sa+3cXUbpaaYYaeHB1Wvd7/3k7zSO/Y
         ZNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=L9/llshy6NEdvrwUOTlVO1RLZRowHloveuPVTU3VHOM=;
        b=taEER+6zEpQa6ExtXeDJIc4joKFr2TDAbqFAbK/JAtvcgpTfD1A9J2xvKQNQLqEytl
         TYKbAgJa7aBJn0d2IKsTjZHTPWIwG6fQix9dytrLYhL+CQbshWNPPCEHLW588S2/JVRa
         ePB3uh/QOB4zOw3UhtYqRphlVfCBT1QfbzfKg1laKHcfSZif9lbWDcXEWujhXNBVv+mr
         AWrZYdInBnaYYMYFOm9k/V9taafuK4X/8aQ64MhKTyPluxpupVGZVXW/wPwRqjZ3dQnb
         4fb7ZRZszr1snm/4giwCQB88Wq8s98degNn6C4c2rIAD/xTlj3sTOtMLuT7Wh2HhZwhA
         wOwA==
X-Gm-Message-State: APt69E17CYqAqug7a8kFRAPXvguTUneKArwkhsa74yAdCPeejAKGJh/O
        nsNRHZJlg7fyg8SZDSsjtKmatQ==
X-Google-Smtp-Source: ADUXVKI5+eG2DqaeEhklxlKMUm7u907Wk9KwLeOg8EVofgNZLYawo+PUpubAD67sqXG9dqJ9pG/SOQ==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr1685895wmb.147.1529950016994;
        Mon, 25 Jun 2018 11:06:56 -0700 (PDT)
Received: from wasted.cogentembedded.com (bzq-219-43-106.isdn.bezeqint.net. [62.219.43.106])
        by smtp.gmail.com with ESMTPSA id s191-v6sm18839053wmd.27.2018.06.25.11.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 11:06:55 -0700 (PDT)
Subject: Re: [PATCH 10/25] dt-bindings: PCI: qcom,ar7100: adds binding doc
To:     John Crispin <john@phrozen.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20180625171549.4618-1-john@phrozen.org>
 <20180625171549.4618-11-john@phrozen.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <5926a597-b2fd-47f8-3a58-bf05d0b7da97@cogentembedded.com>
Date:   Mon, 25 Jun 2018 21:06:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180625171549.4618-11-john@phrozen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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
Content-Length: 1707
Lines: 47

On 06/25/2018 08:15 PM, John Crispin wrote:

> With the driver being converted from platform_data to pure OF, we need to
> also add some docs.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../devicetree/bindings/pci/qcom,ar7100-pci.txt    | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt b/Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
> new file mode 100644
> index 000000000000..97be7b0c4cf9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
> @@ -0,0 +1,36 @@
> +* Qualcomm Atheros AR7100 PCI express root complex
> +
> +Required properties:
> +- compatible: should contain "qcom,ar7100-pci" to identify the core.
> +- reg: Should contain the register ranges as listed in the reg-names property.
> +- reg-names: Definition: Must include the following entries
> +	- "cfg_base"	IO Memory
> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- ranges: ranges for the PCI memory and I/O regions
> +- interrupt-map-mask and interrupt-map: standard PCI
> +	properties to define the mapping of the PCIe interface to interrupt
> +	numbers.
> +- #interrupt-cells: set to <1>
> +- interrupt-parent: phandle to the MIPS IRQ controller

   Never a required prop, can be "inherited" from the parent node.

> +- interrupt-controller: define to enable the builtin IRQ cascade.
> +
> +* Example for ar7100
> +	pcie0: pcie-controller@180c0000 {

   Name it just "pcie@180c0000", please.

[...]

MBR, Sergei
