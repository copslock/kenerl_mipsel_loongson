Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2006 20:40:06 +0200 (CEST)
Received: from wx-out-0102.google.com ([66.249.82.194]:1634 "EHLO
	wx-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133869AbWFBSjx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Jun 2006 20:39:53 +0200
Received: by wx-out-0102.google.com with SMTP id t5so428867wxc
        for <linux-mips@linux-mips.org>; Fri, 02 Jun 2006 11:39:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=YXP9Qd7VY/PQdKOxuAF1odYWuePtS9XkI7KpA/SiWbKdasacF8nvcI5g5QW96pW2hiIkAxcDZ/0R8mSp9OhDTPr0HkejN1h3zZ4S4qLWUAbQYAAeI9w5ToYXiRizb0lI15eYVErfanenviLrH33CUHkYbSm1vK+UtM3AesvpwwY=
Received: by 10.70.89.7 with SMTP id m7mr2770168wxb;
        Fri, 02 Jun 2006 11:39:52 -0700 (PDT)
Received: by 10.70.73.1 with HTTP; Fri, 2 Jun 2006 11:39:52 -0700 (PDT)
Message-ID: <e8180c7f0606021139w6d26e03eice708d5076cccf64@mail.gmail.com>
Date:	Fri, 2 Jun 2006 11:39:52 -0700
From:	"Prasad Boddupalli" <bprasad@cs.arizona.edu>
To:	linux-mips@linux-mips.org
Subject: replacing synthesized tlb handlers with older ones
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 8800841dd708f49b
Return-Path: <p.boddupalli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bprasad@cs.arizona.edu
Precedence: bulk
X-list: linux-mips

Hi,

To embed some additional functionality in the tlb refill handler, I
replaced the synthesized refill handlers in 2.6.16 linux with those
from 2.6.6 (for example tlb-r4k.S under arch/mips/mm-32). Everything
seem ok when I bring up one CPU, but causes unrecoverable exceptions
in the kernel when I bring up multiple CPUs. I explored if that could
be because of unflushed icaches on other CPUs. but that doesn't seem
to be the case.

Have anyone run into similar problem ?

thank you,
Prasad.
