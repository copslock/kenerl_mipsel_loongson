Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Oct 2010 22:52:13 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:56806 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491132Ab0JQUwK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 17 Oct 2010 22:52:10 +0200
Received: by qyk4 with SMTP id 4so287441qyk.15
        for <multiple recipients>; Sun, 17 Oct 2010 13:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p1Jt9vdl8aQ9pvfStWLrZRTg1HPWGv/0I4PU2p9SRZA=;
        b=joK1q99ZAUi/3hefCzmf4tqNwC4ukUk9CgrGfS8B8VG48c0fVM9XrtSguoIZKIrnVH
         ZZmI4CzgBEI8hp9pqYVVXDE9tM2IBCOvl4zTDVMBDLXA2cgIIGiCj+oQEs5HQqlwNhHC
         3OLKM/fBJ9I7998+fIx33BL2gn0LMFptY3DTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VfMzlpw5faI5JVm3tSrunczhzKsk8Xmdt6HjYSNzv8M52aO7CUQCsxeoZnMy0TPlPW
         uG/RyqyHfp907i5+BHGLFfEDFdnGNThbk7ZIK7ePzf+JwM1gFqs+LXI70qtKWcYcJ+P1
         +Mmmzct/S2lNhhhTcEAjy5GGkuoFn4DHgbUlk=
MIME-Version: 1.0
Received: by 10.224.181.140 with SMTP id by12mr1566049qab.182.1287348723098;
 Sun, 17 Oct 2010 13:52:03 -0700 (PDT)
Received: by 10.224.45.148 with HTTP; Sun, 17 Oct 2010 13:52:03 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1010172025110.15889@eddie.linux-mips.org>
References: <AANLkTikP=77Tq=QzFVwexr8fMHg5qmX8fbRjfdkoNSGr@mail.gmail.com>
        <AANLkTikbw1F+jBhsFFyX0vT6CCAqckzLHK3MK2WtTZiA@mail.gmail.com>
        <alpine.LFD.2.00.1010172025110.15889@eddie.linux-mips.org>
Date:   Sun, 17 Oct 2010 13:52:03 -0700
Message-ID: <AANLkTima9n88kAXJbYSr-m_vJnxbEod3VEeW4gLgYyj8@mail.gmail.com>
Subject: Re: Question about Context register in TLB refilling
From:   Kevin Cernekee <cernekee@gmail.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     "wilbur.chan" <wilbur512@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, Oct 17, 2010 at 12:33 PM, Maciej W. Rozycki
<macro@linux-mips.org> wrote:
>> where pgd_current is at 0x8054_5008, and PTEBase is 0, 4, 8, 12, ...
>
>  It has been always making me wonder (though not as much to go and dig
> through our code ;) ) why Linux is uncapable of using the value presented
> by the CPU in the CP0 Context register as is, or perhaps after a trivial
> operation such as a left-shift by a constant number of bits (where the
> size of the page entry slot assumed by hardware turned out too small).
> There should be no need to add another constant as in the piece of code
> you have quoted -- this constant should already have been preloaded to
> this register when switching the context the last time.  The design of the
> TLB refill exception in the MIPS Architecture has been such as to allow
> this register to be readily used as an address into the page table.

On plain old 32-bit MIPS:

The pgd entry for "va" is at address: (unsigned long)pgd + ((va >> 22) << 2)

i.e. each 4-byte entry in the pgd table represents 4MB of virtual address space.

PTEBase only gives you 9 bits to work with.  If you use it to store
pgd[31:23] directly, that means every pgd needs to be 8MB-aligned -
ouch.

You could potentially use PTEBase to store more of the significant bits, e.g.

pgd = 0x8000_0000 | (PTEBase << 12)

But that still places limits on where the pgd table can be stored, and
probably adds a decent number of extra arithmetic operations to each
handler.
