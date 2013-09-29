Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Sep 2013 09:04:56 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49810 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823123Ab3I2HEvE6NLY convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Sep 2013 09:04:51 +0200
Received: by mail-lb0-f174.google.com with SMTP id w6so3461702lbh.19
        for <multiple recipients>; Sun, 29 Sep 2013 00:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tR8vsveopRHINmTXlf9AE7TAqyZpL4ensV0Hz9V1K5o=;
        b=VANXOwqvdcJ6TnjntwHD4pNMQwadKSbnTXbpZXfdQGnMTQa7NGAjKMqaYx51rfta8a
         F+NIlnrOShhM5VcYy8C4Tg2CPVP51L3Jx9zNgsce1t9z1flFoVwCS0mIbi15xC2MhYbM
         0eAUrYu24S5EOu2QiPsmb+jWnhRu7ryXnkbaGtjJnCyFeFQyzwPVJHbw9WH9TuXPJfcp
         3Y7WpTNszzMtOAXlQbko9NGz6HOuuCtp0gz9bSmdNpw4QPKV00sgO8nv57rLdSKdJjfJ
         KukReYI8SPGNnKM8E+A2zRXbWVe8S9LIIIJnUtcfQDjBwx7wq3QdvybpxBGEEh5/17mS
         qSxg==
X-Received: by 10.152.120.99 with SMTP id lb3mr405464lab.31.1380438285249;
        Sun, 29 Sep 2013 00:04:45 -0700 (PDT)
Received: from quiet (ppp37-190-57-6.pppoe.spdop.ru. [37.190.57.6])
        by mx.google.com with ESMTPSA id b6sm13760631lae.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Sep 2013 00:04:44 -0700 (PDT)
Date:   Sun, 29 Sep 2013 11:02:04 +0400
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: vmlinuz: gather some string functions into
 string.c
Message-Id: <20130929110204.ccf96ec638a7400e3eaea511@gmail.com>
In-Reply-To: <524712A7.7060402@gmail.com>
References: <1380382974-27884-1-git-send-email-antonynpavlov@gmail.com>
        <524712A7.7060402@gmail.com>
X-Mailer: Sylpheed 3.4.0beta4 (GTK+ 2.24.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Sat, 28 Sep 2013 19:32:23 +0200
Florian Fainelli <f.fainelli@gmail.com> wrote:

> Hello,
> 
> Le 28/09/2013 17:42, Antony Pavlov a écrit :
> > This patch fixes linker error:
> >
> >      LD    vmlinuz
> >    arch/mips/boot/compressed/decompress.o: In function `decompress_kernel':
> >    decompress.c:(.text+0x754): undefined reference to `memcpy'
> >    make[1]: *** [vmlinuz] Error 1
> >
> > Which appears when compiling vmlinuz image with CONFIG_KERNEL_LZO=y.
> 
> You would have to rebase this on top of mips-for-linux-next which 
> contains a bit more ifdef for supporting LZ4 and XZ otherwise the first 
> hunk of the patch does not apply.

I have read http://www.linux-mips.org/wiki/Git. But there is no information
about mips-for-linux-next. Eventually I have found the branch in the
git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git repo.

Can we update the Git wiki page?

-- 
Best regards,
  Antony Pavlov
