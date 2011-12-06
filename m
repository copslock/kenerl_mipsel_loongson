Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2011 06:40:37 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:44934 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903541Ab1LFFkc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Dec 2011 06:40:32 +0100
Received: by ggnp4 with SMTP id p4so224671ggn.36
        for <linux-mips@linux-mips.org>; Mon, 05 Dec 2011 21:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=v1etU3VmvQqtrxXpPwwvz5vnrxajMJQSBIC6pSlOdms=;
        b=JA0FGJ+BF9ARc5CreuSEn5DMh/DN62UNFD43ek3+3BQoO46zaMobEHLSnnCPoOnjo3
         BEhUzBYEHJs07sWsCCYjgx4gB40vYl3uRVM4U1OF+MvHQaH39HR1+W/69tt4c/K0KKVN
         I9GBmVba8RpcMFFQ3tUyvai3g7yAHVG1Zd00s=
Received: by 10.236.131.82 with SMTP id l58mr16612006yhi.36.1323150026848;
        Mon, 05 Dec 2011 21:40:26 -0800 (PST)
Received: from bubble.grove.modra.org ([115.187.252.19])
        by mx.google.com with ESMTPS id f7sm30953333and.17.2011.12.05.21.40.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Dec 2011 21:40:26 -0800 (PST)
Received: by bubble.grove.modra.org (Postfix, from userid 1000)
        id 189C4170C2BF; Tue,  6 Dec 2011 16:10:19 +1030 (CST)
Date:   Tue, 6 Dec 2011 16:10:19 +1030
From:   Alan Modra <amodra@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     binutils <binutils@sourceware.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>
Subject: Re: [Patch]: Fix ld pr11138 FAILures on mips*.
Message-ID: <20111206054018.GB21034@bubble.grove.modra.org>
Mail-Followup-To: David Daney <david.daney@cavium.com>,
        binutils <binutils@sourceware.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>
References: <4EDD669F.30207@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EDD669F.30207@cavium.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 32042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amodra@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4089

On Mon, Dec 05, 2011 at 04:49:35PM -0800, David Daney wrote:
> The root cause of this is that the mips linker synthesizes a special
> symbol "__RLD_MAP", and then sets MIPS_RLD_MAP to point to it.  When
> a version script is present, this symbol gets versioned along with
> all the rest, and when it is time to take its address, the symbol
> can no longer be found as it has had version information appended to
> its name.

Why not just change

	  && (strcmp (name, "__rld_map") == 0
	      || strcmp (name, "__RLD_MAP") == 0))

to

	  && (strncmp (name, "__rld_map", 9) == 0
	      || strncmp (name, "__RLD_MAP", 9) == 0))

in _bfd_mips_elf_finish_dynamic_symbol?  Perhaps the same for other
syms there too?

-- 
Alan Modra
Australia Development Lab, IBM
