Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 12:04:23 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.203]:7085 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3465570AbWAQMEF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2006 12:04:05 +0000
Received: by zproxy.gmail.com with SMTP id l8so1342728nzf
        for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 04:07:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Q9H3iX+LKcE3T2HYxpSwAxoPjlVABmirT4vOvYvBfek5iHODSqmx+4t4iYlY4xTlmW0YNDXQs4P0oywrrhHYySMg1A4ogzWO0ko35nlBsUSn5M6B+oyMpbOIeOWXIUznFzqBVPkl2bU6Cmo5Z15z/l8NIOFjSZ9666qeWqAw82c=
Received: by 10.36.101.3 with SMTP id y3mr5629261nzb;
        Tue, 17 Jan 2006 04:07:41 -0800 (PST)
Received: by 10.36.49.4 with HTTP; Tue, 17 Jan 2006 04:07:41 -0800 (PST)
Message-ID: <f07e6e0601170407x1d374e46i52eafb7ca697500d@mail.gmail.com>
Date:	Tue, 17 Jan 2006 17:37:41 +0530
From:	Kishore K <hellokishore@gmail.com>
To:	David Daney <ddaney@avtrex.com>
Subject: Re: gcc -3.4.4 and linux-2.4.32
Cc:	linux-mips@linux-mips.org
In-Reply-To: <43CBD91B.4020607@avtrex.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12600_14475249.1137499661943"
References: <f07e6e0601160423h5ce1c0d7lcb7e38f8509c4116@mail.gmail.com>
	 <43CBD91B.4020607@avtrex.com>
Return-Path: <hellokishore@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hellokishore@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_12600_14475249.1137499661943
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 1/16/06, David Daney <ddaney@avtrex.com> wrote:
>
> Kishore K wrote:
> > hi
> > When 2.4.32 kernel (from linux-mips) is compiled with the tool chain
> > based on gcc 3.4.4 and binutils 2.16.1, the kernel crashes on malta
> > board. The crash file is enclosed along with the mail. If the same
> > kernel is compiled with the tool chain based on gcc 3.3.6, no problem i=
s
> > observed.
> >
> > May I know, whether it is because of the changes in ABI in gcc 3.4.
>
> Not exactly.  It has to do with -funit-at-a-time.  In the 2.4.x kernel
> it is assumed that gcc will not reorder top level asm statements and
> functions.  For gcc-3.3.x and earlier this was a valid assumption.  With
> 3.4.x and later it is not.


Thanks for the information.  The board is up, when the kernel is compiled
with the above mentioned option.

--kishore

------=_Part_12600_14475249.1137499661943
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 1/16/06, <b class=3D"gmail_senderna=
me">David Daney</b> &lt;<a href=3D"mailto:ddaney@avtrex.com">ddaney@avtrex.=
com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
Kishore K wrote:<br>&gt; hi<br>&gt; When 2.4.32 kernel (from linux-mips) is=
 compiled with the tool chain<br>&gt; based on gcc 3.4.4 and binutils 2.16.=
1, the kernel crashes on malta<br>&gt; board. The crash file is enclosed al=
ong with the mail. If the same
<br>&gt; kernel is compiled with the tool chain based on gcc 3.3.6, no prob=
lem is<br>&gt; observed.<br>&gt;<br>&gt; May I know, whether it is because =
of the changes in ABI in gcc 3.4.<br><br>Not exactly.&nbsp;&nbsp;It has to =
do with -funit-at-a-time.&nbsp;&nbsp;In the=20
2.4.x kernel<br>it is assumed that gcc will not reorder top level asm state=
ments and<br>functions.&nbsp;&nbsp;For gcc-3.3.x and earlier this was a val=
id assumption.&nbsp;&nbsp;With<br>3.4.x and later it is not.</blockquote><d=
iv><br>
Thanks for the information.&nbsp; The board is up, when the kernel is compi=
led with the above mentioned option.<br>
<br>
--kishore<br>
<br>
</div><br></div><br>

------=_Part_12600_14475249.1137499661943--
