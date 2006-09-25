Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 10:51:54 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.197]:13108 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20038482AbWIYJvu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Sep 2006 10:51:50 +0100
Received: by nz-out-0102.google.com with SMTP id i1so585442nzh
        for <linux-mips@linux-mips.org>; Mon, 25 Sep 2006 02:51:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m8OpS+Qh5XjmtA9v2TbnmroNuZjDy5xC5GRoKAxygLoxjq9iavHNcfZNtJwYxjI8bKEMG7xJEIk2pm15iKQQZRCxAiDeDPTux4MzoC/PxNvmTMTzTBl1oaVwYds5Vje2cuz8cj9/NmYuw77h5zou4mi3P/5Dn8r6iEAXw2amYlw=
Received: by 10.65.59.11 with SMTP id m11mr755154qbk;
        Mon, 25 Sep 2006 02:51:49 -0700 (PDT)
Received: by 10.65.126.13 with HTTP; Mon, 25 Sep 2006 02:51:48 -0700 (PDT)
Message-ID: <b01966ec0609250251kce617e5se9f3cfe8b3d0a2c0@mail.gmail.com>
Date:	Mon, 25 Sep 2006 15:21:48 +0530
From:	"Nida M" <nidajm@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: single step in MIPS
Cc:	"Kevin D. Kissell" <KevinK@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <b01966ec0609062322i249c11a7iea0baf8aa0ee43bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b01966ec0609020445m693b53cfj87d31a4957627f1a@mail.gmail.com>
	 <000b01c6cea8$7d480fa0$a803a8c0@Ulysses>
	 <b01966ec0609032157s35d8c0bdx900956f214c5337b@mail.gmail.com>
	 <20060907035424.GB17965@linux-mips.org>
	 <b01966ec0609062322i249c11a7iea0baf8aa0ee43bd@mail.gmail.com>
Return-Path: <nidajm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nidajm@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,
      I am facing problem in case of branch delay instruction.
      When single stepping is done on a copied page,for an  uncondition jump
      instruction to the given target address ( e.g j, jal ),
      epc jumps to the target address with respect to current address,
      And if I tried to put break point over there....it gives error as
      "CPU 0 Unable to handle kernel paging request at virtual
      address c005eeb8, epc == c005eeb8"


      Can anybody knows...how to solve this problem..?


 ~Nida



On 9/7/06, Nida M <nidajm@gmail.com> wrote:
> > Insert a breakpoint instruction after the instruction you want to single
> > step. Anything that triggers an exception but typicall a "break 0" would
> > be used for debuggers.  Branches need special care.  Either they need to
> > be executed in software or breakpoints at both the branch-taken and the
> > not-taken address need to be inserted.
>
> Instead of break 0, can I use  Trap Exception 'Tr'  with the special
> case for single step BRK_SSTEPBP (break 5)
> E.g : teq rs,rt,code
>
>       which is nothing but :
>       bne rs,rt,1f
>       nop
>       break code
>
> ....... ???
> > And with all those hints I leave the special case of instructions in
> > branch delay slots to the you, I'm sure you'll find it trivial ;-)
>
> Thanks,I think i will do that
>
>
>
>
> ~Nida
>
