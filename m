Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 15:37:48 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.157]:34834 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20030844AbYHLOhn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 Aug 2008 15:37:43 +0100
Received: by fg-out-1718.google.com with SMTP id d23so1253756fga.32
        for <linux-mips@linux-mips.org>; Tue, 12 Aug 2008 07:37:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=IBrseEaWfh9qTfT/eVHBroPY0NF+C4el6CDqnoU0YIk=;
        b=dPawph0/7QRY8JMInYAzO5K6LcAKSE0jerOOBfKv/3CvDsfkTQYtfWyrgi8fkzjRCM
         a1iRXVw3VxQSy/0/X7EY+pL/+GK54MOiLYfH9+M/qsozo7AMQcJ/oTeBbxYjHh8C9Ccv
         a95P/TBtJFS3aBujsoi9nGUITZIqoXVdLYpD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=UTGH/QsUHPOaFbzUatXDI+MUSLFcyx28clxPNAi3xadwSP+9adbirA3LcINuD4d4US
         6ZG0NbtqiByogHkW1TPh773UJK1oODWxjsAla9iU2cCFEUF66puZZL8aU9M+HMQo/n56
         OIoug0RXP11j0r8458usBwFITZoeYJPRggWWs=
Received: by 10.86.95.8 with SMTP id s8mr7218470fgb.6.1218551862019;
        Tue, 12 Aug 2008 07:37:42 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id l12sm5196442fgb.6.2008.08.12.07.37.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Aug 2008 07:37:41 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	linux-mips@linux-mips.org
Subject: Re: Debugging the MIPS processor using GDB
Date:	Tue, 12 Aug 2008 16:37:41 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Martin Gebert <martin.gebert@alpha-bit.de>,
	TriKri <kristoferkrus@hotmail.com>
References: <18944199.post@talk.nabble.com> <48A19ABE.5060104@alpha-bit.de>
In-Reply-To: <48A19ABE.5060104@alpha-bit.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200808121637.42148.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Tuesday 12 August 2008 16:14:22 Martin Gebert wrote:
> > Finally, there's a program called gdbserver, which comes with GDB. If I
> > write a remote stub, do I need this program? Where should it be run? Where
> > should my program be run? Since the stub is a c file, but lacks of a main
> > function, how do I compile it?
> 
> At least this I can answer. In short, you need to call gdbserver on your 
> target machine in order to do remote debugging from your workstation. 
> The first Google match for "using gdbserver" reveals this:
> 
> http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/gdb/server.html

  To the best of my knowledge, ‘gdbserver’ itself is not normally
 used with (E)JTAG probes; it's mostly for debugging userland
 code on a remote target machine whilst running ‘gdb’ itself on
 a local host workstation.

  I'm using the commercial FS² (First Silicon Systems, now owned
 by MIPS) EJTAG probe.  The local ‘gdb’ on the workstation talks
 to the local FS² software on the workstation, which talks to the
 probe (in my case, over USB, but there is also an Ethernet model).
 There is no ‘gdbserver’ in this setup per se, albeit I suppose
 the protocol between ‘gdb’ and the FS² software (which is called
 something like ‘jnetserver’?) might be similar/identical (I have
 no idea!).

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
