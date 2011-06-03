Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Jun 2011 00:52:21 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:50791 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491194Ab1FCWwQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Jun 2011 00:52:16 +0200
Received: by iyb39 with SMTP id 39so2448385iyb.36
        for <multiple recipients>; Fri, 03 Jun 2011 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QcFzpaXl5O5nvRA2y9bRaW3kDB7me1h5mrlIXmJbmvg=;
        b=PWhaE4o2JyTJFkHTRBQTlLQrOXnhViVZmKdN5rx62H3/NbrjjLDNjWRz2B+QAkydIo
         46IEQC0FAATBnGfdVjZoduklBlWCr7tcYkMKBxBNK8L9Vs1WfoPdin7d8vH+7beVbUE0
         lYkj34dB2Klo53KaYav84mxjlGTAgv68rikoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=FDx509LSgl3EIBFZImarpKLtQjnzu6Br9frlqTmzvYHtZq6TxrZ2cFf/UovJEolcUQ
         0+XeXA6qgpn6O4BkNTihrUskVSIs8NyfgFjUr6u44r771oFKDkaXEI9nAWwp9PYdh81P
         XRS3Ob64sZ5YxeD0KT8kXnxe/LJracqcyrD9E=
MIME-Version: 1.0
Received: by 10.42.132.134 with SMTP id d6mr4244122ict.38.1307141529967; Fri,
 03 Jun 2011 15:52:09 -0700 (PDT)
Received: by 10.42.226.67 with HTTP; Fri, 3 Jun 2011 15:52:09 -0700 (PDT)
In-Reply-To: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
Date:   Fri, 3 Jun 2011 15:52:09 -0700
X-Google-Sender-Auth: q22O4eHy6fP53swHBUJ-T83rt3g
Message-ID: <BANLkTik4qRe--C6L5WU3XvpP-TMEZ6RQ-w@mail.gmail.com>
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch ptrace.h
From:   Tony Luck <tony.luck@intel.com>
To:     Eric Paris <eparis@redhat.com>
Cc:     linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        monstr@monstr.eu, ralf@linux-mips.org, benh@kernel.crashing.org,
        paulus@samba.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, linux390@de.ibm.com,
        lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com,
        richard@nod.at, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, viro@zeniv.linux.org.uk,
        oleg@redhat.com, akpm@linux-foundation.org,
        linux-ia64@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony.luck@intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3053

On Fri, Jun 3, 2011 at 3:04 PM, Eric Paris <eparis@redhat.com> wrote:
> The other major change is that on some arches, like ia64, we change
> regs_return_value() to give us the negative value on syscall failure.  The
> only other user of this macro, kretprobe_example.c, won't notice and it makes
> the value signed consistently for the audit functions across all archs.

v2 builds and boots on ia64 now
Acked-by: Tony Luck <tony.luck@intel.com>


> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by: Acked-by: H. Peter Anvin <hpa@zytor.com> [for x86 portion]

  ^^^^^^^^^^^^^^^^^^^^  :-)

-Tony
