Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 16:59:40 +0100 (CET)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:37483
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993086AbeABP7cZrx91 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 16:59:32 +0100
Received: by mail-it0-x241.google.com with SMTP id d137so39833923itc.2;
        Tue, 02 Jan 2018 07:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j44zOeqe+LHgFmN4AozVhhJ2kRJT5yixgJGaSzaey/o=;
        b=lDq+GbWV9GH2qiIHY+ZR9On/p3Wyl6fCgSmhxSFmVntxlKexCI79VKW8AjhAsZXAs0
         CTNyBhetWivBPBUYkUY8yFuHhA57abiLK/isGCnup7aCseDUp6l3DemVA93xHwueRtNi
         yzIyMSdMw/2dphwh8H0/bAkRyiOOS9IfUP+V9m6jtjdsFKxAgB/M4EF64vJY+/iVyhDN
         827snvbKYSDcNK8lhxrFrf7uUMrGX8D2tXmV7jdHPAUF32iDb4jAvdCaP/i5hC3a7Gz1
         qCk68CjMxov45X/42Ub6NP9RfKpw40++wvVcaiBC+umBkEnyYiFYM5gmoW39EP3x3SLy
         VBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j44zOeqe+LHgFmN4AozVhhJ2kRJT5yixgJGaSzaey/o=;
        b=q9CavI3e3Zb6H0OTWyhJJ7coXkVXiDrsyuoHpisCLRLWF41y3aQiUfBL79aJmdZRWF
         x/pKbKutj9aM+aZf4yllfVqt4WNpiMnFuW1Wt83nDHSGvPYc6xnuwmt1x8sW1Iosgkrh
         /1JiGKdiMrjBX1jyxtVDlFAaP877Y5uCX8acevuQ6nDMdK+Vcdhc8n5fmL62UCK77Y5T
         p2An37HrQEKfgeU7ayFRJ0vYQahE4eLq5R5Oa1ENO9SoCzFTM24PCRdNNcs55tTWyOuV
         zyYGuoAPs0axfl/kc+RJK1fCijyLTmj1B9hOE9vnk3L3hBaPaS550ehS4gNNVHONC4wL
         nKUQ==
X-Gm-Message-State: AKGB3mKoKWkatvoUkVzeu3suib1egmivKhgieHt+n3hMVurRt228RpMm
        URAyrf8ECi9yiY7En7qoeG0PK59EH8oz+LDcnVHWuQ==
X-Google-Smtp-Source: ACJfBovDl7KcpTwripd3b8gRNO2SXN6ltn5l2e3lXZotJBHwYfMnplk+9+4PBL/70f3JP4RqARYbXvTfZVbWm0CR5vg=
X-Received: by 10.36.236.4 with SMTP id g4mr46616854ith.33.1514908764082; Tue,
 02 Jan 2018 07:59:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.144.208 with HTTP; Tue, 2 Jan 2018 07:59:23 -0800 (PST)
In-Reply-To: <20180102150848.11314-9-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net> <20180102150848.11314-9-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 2 Jan 2018 21:29:23 +0530
Message-ID: <CANc+2y6YXXtFsjCbxP-WVOSXaN9nmtn5VkQ_ZVdVzpvK_eXbKw@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] MIPS: platform: add machtype IDs for more
 Ingenic SoCs
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

On 2 January 2018 at 20:38, Paul Cercueil <paul@crapouillou.net> wrote:
> Add a machtype ID for the JZ4780 SoC, which was missing, and one for the
> newly supported JZ4770 SoC.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/include/asm/bootinfo.h | 2 ++
>  1 file changed, 2 insertions(+)
>
>  v2: No change
>  v3: No change
>  v5: No change
>
> diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
> index e26a093bb17a..a301a8f4bc66 100644
> --- a/arch/mips/include/asm/bootinfo.h
> +++ b/arch/mips/include/asm/bootinfo.h
> @@ -79,6 +79,8 @@ enum loongson_machine_type {
>   */
>  #define  MACH_INGENIC_JZ4730   0       /* JZ4730 SOC           */
>  #define  MACH_INGENIC_JZ4740   1       /* JZ4740 SOC           */
> +#define  MACH_INGENIC_JZ4770   2       /* JZ4770 SOC           */
> +#define  MACH_INGENIC_JZ4780   3       /* JZ4780 SOC           */
>
>  extern char *system_type;
>  const char *get_system_type(void);
> --
> 2.11.0
>
>

Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
