Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2009 02:58:34 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:44185 "EHLO
        mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494395AbZLIB6b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2009 02:58:31 +0100
Received: by bwz21 with SMTP id 21so4833245bwz.24
        for <linux-mips@linux-mips.org>; Tue, 08 Dec 2009 17:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=8w1kWHiVqUBQakr8iN6vmd9d/yK4h5kZly9AFD6Luzw=;
        b=avjfvxS9qsZejKKkD5kCOXFq6wETvyXxpXphX/IYEYJJ8tJWZMSeiLqCIRYqg7kjgr
         f+Ptu0/sK8yHTG27xEgYuf/XydaxwaZ5NMe+F/+K4fkuwbsilqmyEZGMHdzY9SpeStYj
         cGAtnUIjZSs38UKRBE8K28OkSO1b7+KXXgpWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=HBbk/mWuf8dD2lEvSmBhvxnD/zDpy8AsrCoWSdEP2kBqg6rl8YFAZR+MqvZKH9Q8aC
         5qem+jGfzkacTgKO0ODM/VbdaNeftoOEnrEc0gT3p8N8xrqkzcbYEXlGK/eX/mJ78wJR
         DC2J3jfWVY7fMZMYuUSVPDXKCqgA/nq+nZktQ=
MIME-Version: 1.0
Received: by 10.204.20.79 with SMTP id e15mr9655955bkb.11.1260323906106; Tue, 
        08 Dec 2009 17:58:26 -0800 (PST)
In-Reply-To: <20091207131034.GA5119@linux-mips.org>
References: <7b09df4c0912062339g418f432cr28d92c18ed273d2@mail.gmail.com>
         <20091207131034.GA5119@linux-mips.org>
Date:   Wed, 9 Dec 2009 09:58:26 +0800
Message-ID: <7b09df4c0912081758u794511cdl5a6f103b2303aa52@mail.gmail.com>
Subject: Re: Question: about Physical Address mapping
From:   "Dennis.Yxun" <dennis.yxun@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00032555819eb9b63b047a420692
Return-Path: <dennis.yxun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis.yxun@gmail.com
Precedence: bulk
X-list: linux-mips

--00032555819eb9b63b047a420692
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Dec 7, 2009 at 9:10 PM, Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Dec 07, 2009 at 03:39:15PM +0800, Dennis.Yxun wrote:
>
> > HI ALL:
> >    I have a problem, that our MIPS hardware put registers location from
> > 0x7000,0000 -0x7040,0000.
> > So, I need to init TLB to access those registers.
> >    My question is: can I map those range to Kseg2 (mapped,uncached)? I
> found
> > "add_wired_entry" sit in
> > kernel code, seems I should use this function.
> >
> >    I found code in arch/mips/jazz/irq.c, and the comment tells me
> > /* Map 0xe4000000 -> 0x0:600005C0, 0xe4100000 -> 400005C0 */
> >    add_wired_entry(0x01800017, 0x01000017, 0xe4000000, PM_4M);
> >
> > does that mean after add_wired_entry, virtual address 0xe400,0000 map to
> > physical address 0x600005C0?
> > why the address is 0x6000,05C0, not 0x6000,0000
>
> I probably knew 15 years ago when I wrote this code :)
>
> add_wired_entry() is a very awkard API and its use in the Jazz code is
> broken so I suggest you use ioremap() instead.
>
>  Ralf
>

As you suggested, I plan to use ioremap()
it generally works if I use in my driver code after kernel initialization
finished
but I still have a problem:

How can I access hardware register very early?
say that, use early_printk() to access UART registers,
And I try to put ioremap() at prom_init() to try to remap UART register
but, found that kernel will hang..
the UART register is start from physical address 0x700007c0 (> 512M)
but address below 512M can be remaped successfully

I spend a few minutes digging into the ioremap() function
it simply remap <512M space to KSEG1,
while other physical space use different scheme (map to KSEG2), quite
complicated....

--00032555819eb9b63b047a420692
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Dec 7, 2009 at 9:10 PM, Ralf Baechle <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.o=
rg</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;">
<div><div></div><div class=3D"h5">On Mon, Dec 07, 2009 at 03:39:15PM +0800,=
 Dennis.Yxun wrote:<br>
<br>
&gt; HI ALL:<br>
&gt; =A0 =A0I have a problem, that our MIPS hardware put registers location=
 from<br>
&gt; 0x7000,0000 -0x7040,0000.<br>
&gt; So, I need to init TLB to access those registers.<br>
&gt; =A0 =A0My question is: can I map those range to Kseg2 (mapped,uncached=
)? I found<br>
&gt; &quot;add_wired_entry&quot; sit in<br>
&gt; kernel code, seems I should use this function.<br>
&gt;<br>
&gt; =A0 =A0I found code in arch/mips/jazz/irq.c, and the comment tells me<=
br>
&gt; /* Map 0xe4000000 -&gt; 0x0:600005C0, 0xe4100000 -&gt; 400005C0 */<br>
&gt; =A0 =A0add_wired_entry(0x01800017, 0x01000017, 0xe4000000, PM_4M);<br>
&gt;<br>
&gt; does that mean after add_wired_entry, virtual address 0xe400,0000 map =
to<br>
&gt; physical address 0x600005C0?<br>
&gt; why the address is 0x6000,05C0, not 0x6000,0000<br>
<br>
</div></div>I probably knew 15 years ago when I wrote this code :)<br>
<br>
add_wired_entry() is a very awkard API and its use in the Jazz code is<br>
broken so I suggest you use ioremap() instead.<br>
<font color=3D"#888888"><br>
 =A0Ralf<br>
</font></blockquote></div><br>As you suggested, I plan to use ioremap()<br>=
it generally works if I use in my driver code after kernel initialization f=
inished<br> but I still have a problem:<br><br>How can I  access hardware r=
egister very early?<br>

say that, use early_printk() to access UART registers,<br>And I try to put =
ioremap() at prom_init() to try to remap UART register<br>but, found that k=
ernel will hang..<br>the UART register is start from physical address 0x700=
007c0 (&gt; 512M)<br>

but address below 512M can be remaped successfully<br><br>I spend a few min=
utes digging into the ioremap() function<br>it simply remap &lt;512M space =
to KSEG1, <br>while other physical space use different scheme (map to KSEG2=
), quite complicated....<br>

--00032555819eb9b63b047a420692--
