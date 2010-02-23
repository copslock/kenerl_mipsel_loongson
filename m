Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 21:40:48 +0100 (CET)
Received: from mail-fx0-f217.google.com ([209.85.220.217]:40511 "EHLO
        mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492402Ab0BWUkp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Feb 2010 21:40:45 +0100
Received: by fxm9 with SMTP id 9so3978532fxm.24
        for <multiple recipients>; Tue, 23 Feb 2010 12:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sSZVif38wkxP32cQT9g4m3vqZUZSG1AIKDmMaJXy868=;
        b=vxY7jx2u0lMBSFPmK1DReKMUwIdXS1v1nIRi+/vWBPu+0G6oorWf6F096AMnoGkbtN
         JzL67Qd/CQde2XXmsiOKxbY7f4cFMI9iPzKfz8m7x6RVXv1R7eYPrjwezuJqs1HGy6cy
         /Qp9S0nbhMNaTayMK4A9XoGKrZjMUAaXFgpEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=btTwvgrA97tYGzphuSdz3lDHmPIKR4hSYhSOR5aumznnnqtgl6uJDAE4CvEgctCByW
         BRi6VycARTkpKNyrDMHvsG95HTNVhpcurYQUKMHywMJZDc8rKQnPly1IQnLQWDj0osjx
         AFW5MoqMHZCbR/PS76IEOG3pVh9kor0eo/Bmc=
MIME-Version: 1.0
Received: by 10.223.5.17 with SMTP id 17mr9072402fat.0.1266957638612; Tue, 23 
        Feb 2010 12:40:38 -0800 (PST)
In-Reply-To: <1266538385-29088-3-git-send-email-ddaney@caviumnetworks.com>
References: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
         <1266538385-29088-3-git-send-email-ddaney@caviumnetworks.com>
Date:   Tue, 23 Feb 2010 21:40:38 +0100
Message-ID: <f861ec6f1002231240l40e1b07di6e751e40a2caa110@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: Preliminary vdso.
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi David,

On Fri, Feb 19, 2010 at 1:13 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> This is a preliminary patch to add a vdso to all user processes.
> Still missing are ELF headers and .eh_frame information.  But it is
> enough to allow us to move signal trampolines off of the stack.  Note
> that emulation of branch delay slots in the FPU emulator still
> requires the stack.
>
> We allocate a single page (the vdso) and write all possible signal
> trampolines into it.  The stack is moved down by one page and the vdso
> is mapped into this space.

Is there anything special required (i.e. special glibc, ..) to make use of these
fine patches?

Thanks,
     Manuel Lauss
