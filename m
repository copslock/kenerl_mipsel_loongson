Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 02:04:31 +0200 (CEST)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:52664 "EHLO
	mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493019AbZJVAE2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 02:04:28 +0200
Received: by gxk2 with SMTP id 2so2544816gxk.4
        for <linux-mips@linux-mips.org>; Wed, 21 Oct 2009 17:04:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=q9m89a3GluRyt5eMu9298MLGoyZqJWWIXUekKFMyReY=;
        b=OOK+DiyO/zgdJyrI6qd3lt/2vMGDHtGnoAm04gek+GFgowou6dsZ/QHJrmOoLNfmVe
         3xxdZwFO1aexfmpxa77iDVRboTcV7hX/fDJtXoD/6q4+VbxhNNelMbUmpgQ2PIBXQSa8
         Xt9CKbSv0ckmxjOFCwVYXxDwv3IOSHESRfYFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jgBi73umHIF+6uRf6sNDAH8YIntDCErM4FTp1yKfsQuwQdM5W/lX8wLUtTYv6khUCj
         vxGOUyf8uplTWDYUACvgYee/NGz7SF9bvDpzEJfdyyQ4uNPqhqMt4kGRmPDbACZcge3D
         +vHTU5R28RE8cjJMgOB9tjN7exOHuHmFIn1fo=
MIME-Version: 1.0
Received: by 10.90.233.16 with SMTP id f16mr397064agh.35.1256169861719; Wed, 
	21 Oct 2009 17:04:21 -0700 (PDT)
In-Reply-To: <4ADF32D1.6030801@ru.mvista.com>
References: <e997b7420910210740l4a8fefai27c81152a6c288ef@mail.gmail.com>
	 <4ADF32D1.6030801@ru.mvista.com>
Date:	Thu, 22 Oct 2009 08:04:21 +0800
Message-ID: <e997b7420910211704w67517b3bud6f4757a35945ba@mail.gmail.com>
Subject: Re: Got trap No.23 when booting mips32 ?
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	ddaney@caviumnetworks.com
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

2009/10/22 David Daney <ddaney@caviumnetworks.com>:
> IRQ != c0_cause.ExcCode
>
> You should look up your kernel's IRQ to  interrupt source mapping to see
> what is connected to IRQ 23.
>
> David Daney
>


2009/10/22 Sergei Shtylyov <sshtylyov@ru.mvista.com>:
>   IRQ # is not a trap #, so the rest of your speculations don't apply.
> "unexpected IRQ" probably means that an IRQ occurs for which no handler has
> been installed...
>
> WBR, Sergei
>


Kernal didn't resgister IRQ 23 when booting. Hmm....the only '23'
number I can find in kernel is in traps.c.

Why a 23 IRQ was triggered?
