Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2011 10:21:42 +0200 (CEST)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:32940 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491857Ab1DOIVi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2011 10:21:38 +0200
Received: by wwi18 with SMTP id 18so6945804wwi.0
        for <linux-mips@linux-mips.org>; Fri, 15 Apr 2011 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=03Y0wsXIGLZCPGECkKlTRdsOaPN6xzprDkJ2pobSyo4=;
        b=P4PyJOFz814XvZGyDUrye92yxXlTIYNTNgYe/BmL9Y7FNwqVmAC9w08YVJwePe6HOR
         1C/Vijj9mXeG2p/45++xukyKYQmJwiJbsrhCaI6fE7ftp8tRYO+TwkNMwn8yPQzJCKJz
         GuEa/LE4JWyFQCmm+h0F/IxUkT6JlTxpSDbrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=NBRBDPe2rX1zFq/fzpfmgYdNbjgEtQHIWMhs91q1XMsFuMshFNECz8Fu6YuOSmillI
         GNcMkuFXSs3X6mL2zPHm39HCxLPikOy7LAkvuWKzJqmPl4iiPdmKE1sTGUPYYYBcWQq8
         6RH4UQagX8JV4pOtnBOQNMXUpDTasuhIyUBzk=
Received: by 10.216.143.7 with SMTP id k7mr1628797wej.95.1302855693434;
        Fri, 15 Apr 2011 01:21:33 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id f30sm1168195wef.31.2011.04.15.01.21.31
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 01:21:31 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
Date:   Fri, 15 Apr 2011 10:24:07 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.35-25-server; KDE/4.5.1; x86_64; ; )
Cc:     philby john <pjohn@mvista.com>, linux-mips@linux-mips.org
References: <1302710833.14458.1.camel@localhost.localdomain> <4DA5DF7A.1030207@caviumnetworks.com>
In-Reply-To: <4DA5DF7A.1030207@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201104151024.07859.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello,

On Wednesday 13 April 2011 19:38:02 David Daney wrote:
> On 04/13/2011 09:07 AM, philby john wrote:
> > From: Philby John<pjohn@mvista.com>
> 
> ^^^^^^^^ I believe that statement to be not entirely correct.
> 
> Perhaps you should change it to something like:
> From: David Daney <ddaney@caviumnetworks.com>
> 
> > Date: Wed, 13 Apr 2011 20:46:32 +0530
> > Subject: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
> > 
> > Some early Octeon bootloaders cannot process PT_NOTE program
> > headers as reported in numerous sections of the web, here is
> > an example http://www.spinics.net/lists/mips/msg37799.html
> > Loading usually fails with such an error ...
> > Error allocating memory for elf image!
> > 
> > The work around usually is to strip the .notes section by using
> > such a command $mips-gnu-strip -R .notes vmlinux -o fixed-vmlinux
> > It is expected that the vmlinux image got after compilation be
> > bootable. Add a Kconfig option to ignore the PT_NOTE section.

Do we really want this to be in the kernel? In my opinion, this is a fixup 
which distributions should be aware of, but not necessarily take place here in 
the kernel Makefiles.
--
Florian
