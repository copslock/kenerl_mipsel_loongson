Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2017 20:46:44 +0200 (CEST)
Received: from mail-it0-x22e.google.com ([IPv6:2607:f8b0:4001:c0b::22e]:35939
        "EHLO mail-it0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993970AbdFASqg3nHLF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jun 2017 20:46:36 +0200
Received: by mail-it0-x22e.google.com with SMTP id m47so45176080iti.1
        for <linux-mips@linux-mips.org>; Thu, 01 Jun 2017 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=e0IbSdFFJg3/qY3vrCdM+/pYSS+jZPja4VUnB/MF5CE=;
        b=DVzvPeWFKyl0jblctG3bqwSCnXuUkXXRnThFVPqCxi+HAkeTcsa+WM15ZyphAAekJi
         4ngr5hktBsx2ssUl1Ks5cRcChh+hy4IytLXD76d+k1jIKNuW01wR3xcN7PEM8tnQksF8
         EX/p7o7KgdfWt0cmfVkNAeP+9yu54FZvBEz3cPXBSbOovgKDJiewTELSWEOhCSqypu/H
         E696lyh4wnJLBnkaoToOb0R2OerYXIhPkM4yyIk1077qlOzh5/jBomJTrpE+hJDHzq09
         2Gv0QxUAdQ321ycnJcwFE/4Ercw1O7AsyCURxlIpfhr/R0Jc2QFzLtfU/9H3D5/S96H/
         /dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=e0IbSdFFJg3/qY3vrCdM+/pYSS+jZPja4VUnB/MF5CE=;
        b=iaIhdI+Iz4cqLWG6lAUoX9K1k1lXML8YSBTJD1EC7yhcF9RTe6YvqaaQG92uSj/25+
         YF0GqpUmAoyTLrOzVcXdQPnLQKeyUs03Z48hMAMeqKcpjdRwYOEBeY4HfXABnYPpqTnY
         edSXPAHE5/Dqd9898yNlDHPNGCWeUfZEh+Rl7LRblwPXALhdKE7Gy1BYCTioXp2MsAsJ
         6YWjPRRdnQZ7NkUH24rKDoiDBX+hegrsN8Gzajz2JIK0hkXyN+l3aLueb5DYHRO1jhkn
         bj281ziaUfLxM64UlEMosLjVsqRlbpoCU5H7kz464pPzdF67vJ+fRNJBk3YHVPt/dmfw
         DtyA==
X-Gm-Message-State: AODbwcD/Vz2LmUCkEipUh/VERvVTgQLSpPzqaTjUdgtX6jtAAfXrDBUG
        69DHAQAdej6psjPl+CIdNUm8NVUjow==
X-Received: by 10.36.14.203 with SMTP id 194mr758306ite.56.1496342790727; Thu,
 01 Jun 2017 11:46:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.15.148 with HTTP; Thu, 1 Jun 2017 11:46:29 -0700 (PDT)
In-Reply-To: <20170601173803.8698-1-asarai@suse.de>
References: <20170601173803.8698-1-asarai@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Jun 2017 20:46:29 +0200
X-Google-Sender-Auth: 8kvcKz9P4kq159sdmsHqBzCRmuA
Message-ID: <CAMuHMdXkaWg70OidDi0_xALbzwZ+o0eEVEzT5U_6HdewBs4WwA@mail.gmail.com>
Subject: Re: [PATCH] tty: add TIOCGPTPEER ioctl
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Valentin Rothberg <vrothberg@suse.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Aleksa,

On Thu, Jun 1, 2017 at 7:38 PM, Aleksa Sarai <asarai@suse.de> wrote:
> --- a/arch/alpha/include/uapi/asm/ioctls.h
> +++ b/arch/alpha/include/uapi/asm/ioctls.h
> @@ -94,6 +94,7 @@
>  #define TIOCSRS485     _IOWR('T', 0x2F, struct serial_rs485)
>  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
>  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
> +#define TIOCGPTPEER    _IOR('T', 0x41, int) /* Safely open the slave */

Shouldn't the list of definitions be kept sorted, by hex number?
(everywhere)

>  #define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
>  #define TIOCSIG                _IOW('T',0x36, int)  /* Generate signal on Pty slave */
>  #define TIOCVHANGUP    0x5437

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
