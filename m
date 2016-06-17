Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 18:56:49 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33314 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042878AbcFQQ4rYxQK7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 18:56:47 +0200
Received: by mail-pa0-f65.google.com with SMTP id ts6so6141986pac.0
        for <linux-mips@linux-mips.org>; Fri, 17 Jun 2016 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zg5ao2nErkcLS8QBP31yv9vqesAdVCXH/FEUa3/vfy0=;
        b=pafgx0QwZBLeHat0hsHNiY9RkROm//pS9ASpK/1KAAmCUy67bXmM+m+LJy/Lu54Tet
         R9BF0enBnUSRyUeQ+w/rA9DfPQ37OWVM+nT/ycEPz/fmrjNq6s7cLNr6pFWFCUU6q0iz
         ntyC9YQxlQZPGg7BML7hgQrn1szZyd9jwByLiATwWKl9aqSsXZnbA1cSjThcQuBC5jxu
         St9vZYhf8rZ7iVPpa2cScOU4mu9FDLQzyhp7Ob+/G8nxXFsrkLWKB9HtmxDIHNQxMr7o
         XKZpRX2q46LH0+6Y7pJLqwenrP96etzfgLNlmvKwInUXGoW5ZG48tfBHbLejei/875Nf
         LZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zg5ao2nErkcLS8QBP31yv9vqesAdVCXH/FEUa3/vfy0=;
        b=kVyEdNsjKsd702LzPgNQZ/CxLR0sKx26fJolKIYxLGVArVK27WJagy7XUGN3Jps8s9
         LgFCgJxQiyRxGqgaMMKpcGpO9gPe4JxEJuWAj6kEnV7i0xWmBxRTRYmyMSDcATyoRViJ
         VoHBkXZcK5fVxrA5KvxdrJBro2b3ICYrWfilgeRi6BI7xPkFbOnVeU7NdWL+lP2I7dlX
         eI4HGiCFeo6atzfLDpzIaZldL0nR/v+Qw0oASpjLJ051gDHZOun/jLm+iw2N3EEhYOTB
         yF2I5nOEsbIVMf5QMJr4RBn2TQRbTrHbEDK2s/kX0crgSvgYzw/SX9qoie0VD0LTHmZy
         odmw==
X-Gm-Message-State: ALyK8tIz4jK4vDLh7PyDShGFgUn8VbX7BYgpCSzgHgidwotqWSLPbkvjZuI26rI+4auG/g==
X-Received: by 10.66.228.193 with SMTP id sk1mr3337412pac.54.1466182601117;
        Fri, 17 Jun 2016 09:56:41 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:e162:d192:ee93:fb71? ([2601:645:c200:33:e162:d192:ee93:fb71])
        by smtp.gmail.com with ESMTPSA id v126sm7008207pfb.60.2016.06.17.09.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2016 09:56:40 -0700 (PDT)
Message-ID: <1466182596.5921.5.camel@chimera>
Subject: Re: [PATCH 2/2] MIPS: store the appended dtb address in a variable
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alban Bedel <albeu@free.fr>
Date:   Fri, 17 Jun 2016 09:56:36 -0700
In-Reply-To: <1466165260-6897-3-git-send-email-jogo@openwrt.org>
References: <1466165260-6897-1-git-send-email-jogo@openwrt.org>
         <1466165260-6897-3-git-send-email-jogo@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Fri, 2016-06-17 at 14:07 +0200, Jonas Gorski wrote:
> +++ b/arch/mips/pic32/pic32mzda/init.c
> @@ -33,8 +33,8 @@ static ulong get_fdtaddr(void)
>  {
>         ulong ftaddr = 0;
>  
> -       if ((fw_arg0 == -2) && fw_arg1 && !fw_arg2 && !fw_arg3)
> -               return (ulong)fw_arg1;
> +       if (fw_passed_dtb && !fw_arg2 && !fw_arg3)
> +               return (ulong)fw_passed_dtb;

This part potentially violates the UHI spec. If fw_passed_dtb is valid
but fw_arg0 > 0, fw_arg2 may still be a valid envp. Comparing otherwise
undefined values to zero is also incorrect.
