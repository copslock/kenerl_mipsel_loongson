Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2011 00:44:03 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:63612 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903626Ab1LFXn7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2011 00:43:59 +0100
Received: by ggnp4 with SMTP id p4so1403578ggn.36
        for <linux-mips@linux-mips.org>; Tue, 06 Dec 2011 15:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fXdpyfC+sq4VIISAS3BfE8BMznan0nC98A3O9CFQh6U=;
        b=hzp+3XAsgFspHk7amLEhkavttjaXHIjG+wBkGWLGz0XLHMb05E2feqUTVNTs5GG1W+
         VU932tbqy7v3SJY8xyDHAhG5blDn1OpVHYjxIzZ+5ht41ShVHpzfthdl3k798Ve+b8ru
         IHL4zOFeTJEnvYOcwsrzT9uF8pKNxYGzLCSyk=
Received: by 10.100.76.4 with SMTP id y4mr40126ana.33.1323215033816;
        Tue, 06 Dec 2011 15:43:53 -0800 (PST)
Received: from bubble.grove.modra.org ([115.187.252.19])
        by mx.google.com with ESMTPS id f47sm39950835yhh.8.2011.12.06.15.43.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 15:43:53 -0800 (PST)
Received: by bubble.grove.modra.org (Postfix, from userid 1000)
        id 2B0BE170C2BF; Wed,  7 Dec 2011 10:13:46 +1030 (CST)
Date:   Wed, 7 Dec 2011 10:13:46 +1030
From:   Alan Modra <amodra@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     binutils <binutils@sourceware.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>
Subject: Re: [Patch]: Fix ld pr11138 FAILures on mips*.
Message-ID: <20111206234345.GC21034@bubble.grove.modra.org>
Mail-Followup-To: David Daney <david.daney@cavium.com>,
        binutils <binutils@sourceware.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>
References: <4EDD669F.30207@cavium.com>
 <20111206054018.GB21034@bubble.grove.modra.org>
 <4EDE78FE.2050509@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EDE78FE.2050509@cavium.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 32049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amodra@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5146

On Tue, Dec 06, 2011 at 12:20:14PM -0800, David Daney wrote:
> Then "__RLD_MAP" gets hidden and we never see it in
> _bfd_mips_elf_finish_dynamic_symbol().

I see.  Well, the real question is whether this symbol needs to be
dynamic.  If it does, then you can't allow it to be hidden.  That
would best be accomplished by writing a mips elf_backend_hide_symbol
function, which is nicer than adding another field used by only one
target to struct elf_link_hash_entry.  

-- 
Alan Modra
Australia Development Lab, IBM
