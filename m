Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 20:56:16 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:38185 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S23871867AbYGBT4J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Jul 2008 20:56:09 +0100
Received: by nf-out-0910.google.com with SMTP id h3so145727nfh.14
        for <linux-mips@linux-mips.org>; Wed, 02 Jul 2008 12:56:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=Fcjc+mfdyY8AvqUKoZxxJr8gIq3fGDsnY3eUf3hJ+dk=;
        b=pUus5Fo1FqM9RCBiBSzLCTn9N6p2pHwZDJ/UlLhiSBkWUz4eQ4yeZjhiGrmOlELypE
         Zn9U6Esbvn92Kb6dpY6LtS/cSkkQRNaZGpVmGOYvEOO9xjq5rhTY9ShRmx+9RgCJ5QKw
         njNogLoLC9XIp6Qept96DpPADMnpl1ozVVn/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=YhGaB3yGhgrhIDeiTP2Y3IC0iNZW83Bgx+rzYj9tLX4iJyNIwRLJIVwc6qtxmol17g
         NxPpcd2+rUXeFRf070z3S3/LuNu4jvlOFbdU0BxE6zXCUQNQPXBL+/9uTgLHeqlyWbfV
         xFkjsyHWPD0PkCFcZlgOSREOpM96ufSYI07jg=
Received: by 10.210.34.2 with SMTP id h2mr6958630ebh.122.1215028567483;
        Wed, 02 Jul 2008 12:56:07 -0700 (PDT)
Received: from localhost ( [79.67.7.185])
        by mx.google.com with ESMTPS id g11sm4839009gve.8.2008.07.02.12.56.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jul 2008 12:56:04 -0700 (PDT)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	binutils@sourceware.org
Mail-Followup-To: binutils@sourceware.org,gcc@gcc.gnu.org,  linux-mips@linux-mips.org, rdsandiford@googlemail.com
Cc:	gcc@gcc.gnu.org, linux-mips@linux-mips.org
Subject: Re: RFC: Adding non-PIC executable support to MIPS
References: <87y74pxwyl.fsf@firetop.home>
	<20080701202236.GA1534@caradoc.them.org> <87zlp149ot.fsf@firetop.home>
	<20080702120829.GA12595@caradoc.them.org>
Date:	Wed, 02 Jul 2008 20:55:54 +0100
In-Reply-To: <20080702120829.GA12595@caradoc.them.org> (Daniel Jacobowitz's
	message of "Wed\, 2 Jul 2008 08\:08\:29 -0400")
Message-ID: <87abh0m56d.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Thanks to everyone for their kind messages.  I won't drag this out
for non-MIPS folk by replying publicly to each one.

Daniel Jacobowitz <dan@debian.org> writes:
> the GOT cleanups in particular look very useful.

Thanks.  To be clear: the withdrawal was simply for the patches in this
message.  Although the original motivation for the GOT cleanups was to
reduce the amount of wasted space in mostly-non-PIC executables,
they're really a separate change in their own right.  My hope was that,
even without the non-PIC stuff, the new code might be more maintainable
than what we have now.

> We could have done more to keep everyone informed of our progress; I
> could write an essay on why we didn't, but I'd rather not.  We're
> talking internally about how to avoid this unfortunate coincidence in
> the future.  Anyway, there's plenty of blame to go around.

FWIW, I don't blame MTI or CS at all for this.  Duplicated effort is
part of the risk one runs with the model that both you (CS) and I were
following.  (And for the record, I say "I" because the fault was mine
rather than Specifix's.)

When I was doing the work, I was expecting to use the patches as the
basis for a discussion on this list.  And I honestly expected to have to
change some of the details as a result.  E.g. I wasn't sure what the
reaction would be to requiring MIPS II or above.  So it's no surprise
that my version as posted is not going to be used.

And when I learnt about your alternative implementation, I was expecting
some of that implementation to be chosen instead.  The difficulty was
simply that, as you rightly said, MTI are the authority here.  That made
any discussion on this list moot.

That was just an attempt to clarify things rather than force you
into writing an essay ;)

Anyway, enough of that.  Back to technical stuff.  Would it work if we
had stubs like this:

        lui     t7,%hi(.got.plt entry)
        lw      t9,%lo(.got.plt entry)(t7)
        addiu   t8,t7,%lo(.got.plt entry)
        jr      t9
        ...
        lui     t7,%hi(.got.plt entry + 4)  [next entry]
        
and a header like this:

        lui     gp,%hi(.got.plt)
        lw      t9,%lo(.got.plt)(gp)
        addiu   gp,gp,%lo(.got.plt)
        subu    t8,t8,gp
        move    t7,ra
        srl     t8,t8,2
        jalr    t9
        subu    t8,t8,2

(Key for my benefit, 'cos I can only think in terms of numerical
registers:

        t7 = $15
        t8 = $24
        t9 = $25)

The size of the header and first 0x10000 stubs would be the same.
I think it would also preserve the resolver interface while removing
the need for the extra-large .plts.  The only incompatibility I can
see would be that objdump on older executables would not get the
foo@plt symbols right for large indices.

OTOH, perhaps you could argue that the extra complication of the
two PLT entries doesn't count for much given that the code is
already written.  It's just an idea.

Richard
