Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2008 21:43:47 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:10370 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S32713841AbYGAUnl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Jul 2008 21:43:41 +0100
Received: by nf-out-0910.google.com with SMTP id h3so16194nfh.14
        for <linux-mips@linux-mips.org>; Tue, 01 Jul 2008 13:43:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=RG0+zZm9lEcSl0UtOGVWsJNj10aIWS+uSrnoKNY+8UA=;
        b=u4Mcwx+zh+3EkHmBGYCew6ks7PbxPbcKertCRGcVVjwY7zJu8uo4a4ZT0Y9xRapEQc
         gX0e164IzhD/HRGw9efSe1POIhJFPTGmxkZZiwe+oTlOTGXsjNseOXLe+1Wuf26lSWmI
         5maD/WvQaMJjskXTk22/XgBHg17muE26ck52Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=W1H5yf66Qjyd/PixPUBs0qF9IMDJEvR2jPevANs/muU5KWkNjzusF+3Eh9TaqYh5Wu
         pWTy7o7TWbDkoZTuujnN1y7xraewv3K013o38+IJeSJGTCY8T/izEaEhX3/hSjSpT8dn
         IUxOk488mYlKHB/BHJVm3EUuVIrDF3D10ALxI=
Received: by 10.210.21.13 with SMTP id 13mr5777669ebu.75.1214945020292;
        Tue, 01 Jul 2008 13:43:40 -0700 (PDT)
Received: from localhost ( [79.75.55.39])
        by mx.google.com with ESMTPS id u14sm13662329gvf.6.2008.07.01.13.43.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jul 2008 13:43:38 -0700 (PDT)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	binutils@sourceware.org
Mail-Followup-To: binutils@sourceware.org,gcc@gcc.gnu.org,  linux-mips@linux-mips.org, rdsandiford@googlemail.com
Cc:	gcc@gcc.gnu.org, linux-mips@linux-mips.org
Subject: Re: RFC: Adding non-PIC executable support to MIPS
References: <87y74pxwyl.fsf@firetop.home>
	<20080701202236.GA1534@caradoc.them.org>
Date:	Tue, 01 Jul 2008 21:43:30 +0100
In-Reply-To: <20080701202236.GA1534@caradoc.them.org> (Daniel Jacobowitz's
	message of "Tue\, 1 Jul 2008 16\:22\:37 -0400")
Message-ID: <87zlp149ot.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz <dan@debian.org> writes:
> We've shipped our version.  Richard's version has presumably also
> shipped.

Right.

> We did negotiate the ABI changes with MTI; this is not quite
> as good as doing it in full view, but it was the best we could manage
> and MTI is as close to a central authority for the MIPS psABI as
> exists today.
>
> Richard, what are your thoughts on reconciling the differences?  You
> can surely guess that I want to avoid changing our ABI now, even for
> relatively significant technical reasons - I'm all ears if there's a
> major reason, but in the comparisons I do not see one.

I suppose I still support the trade-off between the 5-insn MIPS I stubs
(with extra-long variation for large PLT indices) and the absolute
.got.plt address I used.  And I still think it's shame we're treating
STO_MIPS_PLT and STO_MIPS16 as separate; we then only have 1 bit of
st_other unclaimed.

However, IMO, your argument about MTI being the central authority
is a killer one.  The purpose of the GNU tools should be to follow
appropriate standards where applicable (and extend them where it
seems wise).  So from that point of view, I agree that the GNU tools
should follow the ABI that Nigel and MTI set down.  Consider my
patch withdrawn.

TBH, the close relationship between CodeSourcery and MTI
make it difficult for a non-Sourcerer and non-MTI employee
to continue to be a MIPS maintainer.  I won't be in-the-know
about this sort of thing.

I've been thinking about that a lot recently, since I heard about
your implementation.  I kind-of guessed it had been agreed with MTI
beforehand (although I hadn't realised MTI themselves had written
the specification).  Having thought it over, I think it would be best
if I stand down as a MIPS maintainer and if someone with the appropriate
commercial connections is appointed instead.  I'd recommend any
combination of yourself, Adam Nemet and David Daney (subject to
said people being willing, of course).

Richard
