Return-Path: <SRS0=t3Ks=S7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386FAC43219
	for <linux-mips@archiver.kernel.org>; Mon, 29 Apr 2019 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EBC2063F
	for <linux-mips@archiver.kernel.org>; Mon, 29 Apr 2019 15:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppT6h3G9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfD2PWC (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:22:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41385 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfD2PWB (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 29 Apr 2019 11:22:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id m4so9475067edd.8;
        Mon, 29 Apr 2019 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZZLpdCaY45ZaWdwl3+E5Jd3Cq8zuL6naI6wCwSuVKCg=;
        b=ppT6h3G9NuDkcYADi9LW7X3uSGDINXrGpBwPcqsBRDIwXcck7cMScr22OMFoQ4Q7dW
         8uh86qWSdCnDSh32a04j0feRNOwLlME9xwUQVKfgPlstvStLeefqu2rH6ctjy4IBUOxV
         0P0njK4P60TKRpkJScyHOWfv1632H2NqB/u65mqvsAgn8LRYGDLgrAGBd7Cg0dA4XFPY
         n/8jtVt529dPhZATwWpD1GFMOYJDyzMVBjkgHGjF4ebsEjG315Nc+bx3U2dCTC6VylmX
         CPnB7mvnD2IcDGboMWFxmbnYxHKPLBWhHPOFppg2uPmIHZWARZSoVFjkzBRZXy+KJFjB
         hzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZZLpdCaY45ZaWdwl3+E5Jd3Cq8zuL6naI6wCwSuVKCg=;
        b=CgpH3OWrjVAaJEkaJ0ZaE6SItDpF3kwZVAASTXVhMt2k647q+LVgd71G3Yu4ioE21U
         fqzhS3ZDxeTZX884IDfT1PX6h71XEGsI8+Xt6esr0ufmst5Ow58bJzGawx0G00bdxG5t
         OHvOOj/sthf0gqpSfe7c3u6SoPGBAYDI3Th36OBRANwhlH8cjv7Y+2Kx33XVsrvbyeM2
         QxGEoEIAGjQmYUi85qGDTJm6UJ44C8HSXnW04lWohgszFXzPW6tejlYMb/4Bvo5Nu1sp
         Ymt34vkPoEMCGIcsQWzufgAgHN6zUrdGb0BOPOfD8q3E50BYUWKxqcj9hSnMEDNGmZQt
         g/DQ==
X-Gm-Message-State: APjAAAXj9gRM/5x+95SRZXxwDQ1MtXOOFqEZUIG91DheyCXIeqMWE2ZL
        eWOonpgWvBcdl4g+9bnMAcg=
X-Google-Smtp-Source: APXvYqxamfPfJ9uZ6AGqPNu4zJZ93wicN/YjM8vFds68tQNGSe4lFFbL+0I10So0tU7LuEyBIVAoBA==
X-Received: by 2002:a50:b35a:: with SMTP id r26mr38872334edd.239.1556551319341;
        Mon, 29 Apr 2019 08:21:59 -0700 (PDT)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id c8sm2079732ejs.41.2019.04.29.08.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 08:21:58 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1hL86P-0000gI-Kz; Mon, 29 Apr 2019 17:21:57 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     "Enrico Weigelt\, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org,
        andrew@aj.id.au, gregkh@linuxfoundation.org, sudeep.holla@arm.com,
        liviu.dudau@arm.com, linux-mips@vger.kernel.org, vz@mleia.com,
        linux@prisktech.co.nz, sparclinux@vger.kernel.org,
        khilman@baylibre.com, macro@linux-mips.org,
        slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk,
        linux-amlogic@lists.infradead.org,
        andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
        davem@davemloft.net
Subject: Re: [PATCH 15/41] drivers: tty: serial: uartlite: fix use fix bare 'unsigned'
References: <1556369542-13247-1-git-send-email-info@metux.net>
        <1556369542-13247-16-git-send-email-info@metux.net>
Date:   Mon, 29 Apr 2019 17:21:57 +0200
In-Reply-To: <1556369542-13247-16-git-send-email-info@metux.net> (Enrico
        Weigelt's message of "Sat, 27 Apr 2019 14:51:56 +0200")
Message-ID: <87ef5krg4q.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

>>>>> "Enrico" == Enrico Weigelt, metux IT consult <info@metux.net> writes:

 > Fix checkpatch warnings:
 >     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
 >     #562: FILE: drivers/tty/serial/uartlite.c:562:
 >     +	unsigned retries = 1000000;

 >     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
 >     #574: FILE: drivers/tty/serial/uartlite.c:574:
 >     +				 const char *s, unsigned n)

s/fix use fix/fix use of/ in Subject. Other than that:

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
