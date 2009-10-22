Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 02:02:33 +0200 (CEST)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:46783 "EHLO
	mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493019AbZJVAC0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Oct 2009 02:02:26 +0200
Received: by gxk2 with SMTP id 2so2543624gxk.4
        for <linux-mips@linux-mips.org>; Wed, 21 Oct 2009 17:02:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lJGfaq312dIbD4FHmNKgpMGPy0NVFcakB1mF5JJFF1A=;
        b=O+01rxmgEy7rbHZwBM5GEwPxSNaMVA+LUhj4Q4o9al9E8MowEZcfv4X3KxGpQPLRwL
         kCYsX4ATX/uNwhhJeYnlYiP4UBXdxrqmixxXZyqsKoo8692ly2gHYzjcqm9RXnsgMmQd
         +nXURx4YTMQkOO4ripbb2gHe6rYFuCkJyDpr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fqMWYNEa7mdEL52NQ+59td+AihWbaD+JSLSpGWDwHTRbOwU8IYZa/Mk4kHL6lI7VCJ
         w6JN+chyUcEVCKh/TWUyWzh0mLYG3Vy6hC4pKyw/jvO3bRhFxxPqpgCDckpucJTKiq2Z
         Erh3mCIhT2WzD3IPmfxgrjuYg2OO5ROw3QvIU=
MIME-Version: 1.0
Received: by 10.90.41.29 with SMTP id o29mr9918141ago.101.1256169740226; Wed, 
	21 Oct 2009 17:02:20 -0700 (PDT)
In-Reply-To: <4ADF3240.9040900@caviumnetworks.com>
References: <e997b7420910210740l4a8fefai27c81152a6c288ef@mail.gmail.com>
	 <4ADF3240.9040900@caviumnetworks.com>
Date:	Thu, 22 Oct 2009 08:02:20 +0800
Message-ID: <e997b7420910211702i14fe8e23v890231e692aba151@mail.gmail.com>
Subject: Re: Got trap No.23 when booting mips32 ?
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

2009/10/22 David Daney <ddaney@caviumnetworks.com>:

> IRQ != c0_cause.ExcCode
>
> You should look up your kernel's IRQ to  interrupt source mapping to see
> what is connected to IRQ 23.
>
> David Daney
>

2009/10/22 Sergei Shtylyov <sshtylyov@ru.mvista.com>:
>> No.23 trap is a Watch trap, which means that, when
>
>   IRQ # is not a trap #, so the rest of your speculations don't apply.
> "unexpected IRQ" probably means that an IRQ occurs for which no handler has
> been installed...
>
> WBR, Sergei
>

Kernal didn't resgister IRQ 23 when booting. Hmm....the only '23'
number I can find in kernel is in traps.c.

Why a 23 IRQ was triggered?
