Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 15:20:01 +0100 (BST)
Received: from RT-soft-2.Moscow.itn.ru ([IPv6:::ffff:80.240.96.70]:61154 "HELO
	mail.dev.rtsoft.ru") by linux-mips.org with SMTP
	id <S8225205AbUIXOT5>; Fri, 24 Sep 2004 15:19:57 +0100
Received: (qmail 17087 invoked from network); 24 Sep 2004 14:03:45 -0000
Received: from unknown (HELO dev.rtsoft.ru) (192.168.1.199)
  by mail.dev.rtsoft.ru with SMTP; 24 Sep 2004 14:03:45 -0000
Message-ID: <41542D07.8070608@dev.rtsoft.ru>
Date: Fri, 24 Sep 2004 18:19:51 +0400
From: Pavel Kiryukhin <savl@dev.rtsoft.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Ralf Baechle <ralf@linux-mips.org>,
	Pavel Kiryukhin <savl@dev.rtsoft.ru>
Subject: Re: __stq_u parameter (and related XFS filesystem 1.3 & 1.3.1 problems
 on 2.4.x)
References: <4152EABF.1020007@dev.rtsoft.ru> <20040923205946.GA375@linux-mips.org>
In-Reply-To: <20040923205946.GA375@linux-mips.org>
Content-Type: multipart/alternative;
 boundary="------------010103060104080103060509"
Return-Path: <savl@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: savl@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010103060104080103060509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Just in case it may help somebody..
This patch  is necessary for normal 1.3 and 1.3.1 XFS filesystem  
operations on  mips targets (LE especially) with  old (2.4) kernels.
----
Pavel

Ralf Baechle wrote:

>On Thu, Sep 23, 2004 at 07:24:47PM +0400, Pavel Kiryukhin wrote:
>
>  
>
>>Sorry,
>>does this make sense for 2.4.x kernels?
>>    
>>
>
>Once uppon a time it made ...
>
>The file has been rewritten completly since then.
>
>Thanks anyway,
>
>  Ralf
>
>  
>


--------------010103060104080103060509
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Just in case it may help somebody..<br>
This patch&nbsp; is necessary for normal 1.3 and 1.3.1 XFS filesystem&nbsp;
operations on&nbsp; mips targets (LE especially) with&nbsp; old (2.4) kernels.<br>
----<br>
Pavel<br>
<br>
Ralf Baechle wrote:<br>
<blockquote type="cite" cite="mid20040923205946.GA375@linux-mips.org">
  <pre wrap="">On Thu, Sep 23, 2004 at 07:24:47PM +0400, Pavel Kiryukhin wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">Sorry,
does this make sense for 2.4.x kernels?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Once uppon a time it made ...

The file has been rewritten completly since then.

Thanks anyway,

  Ralf

  </pre>
</blockquote>
<br>
</body>
</html>

--------------010103060104080103060509--
