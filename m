Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2008 23:03:11 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:4231 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S32716728AbYGAWDF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Jul 2008 23:03:05 +0100
Received: by nf-out-0910.google.com with SMTP id h3so24648nfh.14
        for <linux-mips@linux-mips.org>; Tue, 01 Jul 2008 15:03:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=QmXN6RhKS0/S1/XTXrOP6Zl+KiStHwWJlFhVEynpZ5w=;
        b=a5s8+RTGjm9dn1e4VxtQEJmGh/1dVKndynHMOrj8DVtPfPyfuikIZODnq64UzVF1as
         zL7zTqjbVjfmnl0XORGxoRMHnzwzDIYCI+BdKbcYfkVU/Us6f2d1G6wtkoWE/UbAS+T2
         Xl8TfSQ3fN1xr3towMcXzyNIuvcwtBLe3Dt8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=YZbKp/A7koACVvpypMHopcBP0rV3g5B4iXX1nJV1IWed4Ss4A3Rte32Ob/1RP0Zupa
         DbpM+0UjAYw9BO6T3ZjUfFeEny9AYkpG8jLTSco1Ap9JrB0VntlshYNZZ7wZ3pst72rI
         kCTMQiM92ZmA+6pY3a23hk5DwzV6O4WlulvsY=
Received: by 10.210.76.19 with SMTP id y19mr5777304eba.186.1214949783944;
        Tue, 01 Jul 2008 15:03:03 -0700 (PDT)
Received: from localhost ( [79.75.55.39])
        by mx.google.com with ESMTPS id i6sm2211941gve.4.2008.07.01.15.03.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jul 2008 15:03:02 -0700 (PDT)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	binutils@sourceware.org
Mail-Followup-To: binutils@sourceware.org,gcc@gcc.gnu.org,  linux-mips@linux-mips.org, rdsandiford@googlemail.com
Cc:	gcc@gcc.gnu.org, linux-mips@linux-mips.org
Subject: Re: RFC: Adding non-PIC executable support to MIPS
References: <87y74pxwyl.fsf@firetop.home>
	<20080701202236.GA1534@caradoc.them.org> <87zlp149ot.fsf@firetop.home>
Date:	Tue, 01 Jul 2008 23:02:59 +0100
In-Reply-To: <87zlp149ot.fsf@firetop.home> (Richard Sandiford's message of
	"Tue\, 01 Jul 2008 21\:43\:30 +0100")
Message-ID: <87r6ad460c.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford <rdsandiford@googlemail.com> writes:
> I've been thinking about that a lot recently, since I heard about
> your implementation.  I kind-of guessed it had been agreed with MTI
> beforehand (although I hadn't realised MTI themselves had written
> the specification).  Having thought it over, I think it would be best
> if I stand down as a MIPS maintainer and if someone with the appropriate
> commercial connections is appointed instead.  I'd recommend any
> combination of yourself, Adam Nemet and David Daney (subject to
> said people being willing, of course).

I realised afterwards that this might be offensive by who it left out.
For the record, it wasn't supposed to be an exclusive list.  Other people
have strong claims too. ;)

Richard
