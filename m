Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2008 12:29:32 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.185]:62370 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20818966AbYJGL3W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Oct 2008 12:29:22 +0100
Received: by ti-out-0910.google.com with SMTP id i7so1740210tid.20
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2008 04:29:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=mkC4s1BC8TYGg6qLhGnT1i5X6vCpv4q5HKok0+AQlhg=;
        b=mtQqPLyKuijDgrTPDSoNjJQklQ43Jmf3PePRy5N9CoQKlFAlpy4Ohysmr+HOBoXwQ/
         3+X3ZT91FIaCW9DapAwAWm2XFC3iE0x3uMdVkvS9nQMPQZ7tQ9bHPx5EqjLhQb/1sqjU
         rwFOstHZKXRXQmlY0SszDUyjZ12Xzqb9twy6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=lSnU9cKB1xN3MH8shsYOqT7iWh7RBVGUu8Cc5xaDSvj5M69oX+41LdQb66kRUxndpU
         I3OXYq0h4nGIr+0Rz/+PKp6SsR7oAgVT2D6zT7Ppc5V90kUo6kbGMhv/RD1vJz9qCw8k
         vpS7eCinqMYGYdiqlNfVpCLuXXdNqlvw5UjAc=
Received: by 10.110.7.5 with SMTP id 5mr7950092tig.7.1223378959100;
        Tue, 07 Oct 2008 04:29:19 -0700 (PDT)
Received: by 10.110.47.3 with HTTP; Tue, 7 Oct 2008 04:29:19 -0700 (PDT)
Message-ID: <da30b7ef0810070429k67b99995y18ffc251ed58ba70@mail.gmail.com>
Date:	Tue, 7 Oct 2008 16:59:19 +0530
From:	"V!j@y Chandran" <vijayachandran.m@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Reg: Microwindow on Mips.
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4283_12361670.1223378959082"
Return-Path: <vijayachandran.m@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vijayachandran.m@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_4283_12361670.1223378959082
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am trying to port Microwindow on MIPS based Hardware.

While crosscompiling Microwindows (microwindows-src-snapshot.tar.gz) for
MIPS, i am getting linking error.

Linking /opt/stb/microwindows-0.90/src/bin/nano-X ...
/opt/stb/crosstools/bin/../lib/gcc/mipsel-linux-uclibc/3.4.6/../../../../mipsel-linux-uclibc/bin/ld:

warning: ld-uClibc.so.0, needed by
/opt/stb/crosstools/bin/../lib/gcc/mipsel-linux-uclibc/3.4.6/../../../../mipsel-linux-uclibc/lib/libc.so,

not found (try using -rpath or -rpath-link)
/opt/stb/crosstools/bin/../lib/gcc/mipsel-linux-uclibc/3.4.6/../../../../mipsel-linux-uclibc/lib/libc.so:

undefined reference to `__libc_stack_end'
collect2: ld returned 1 exit status
make[1]: *** [/opt/stb/microwindows-0.90/src/bin/nano-X] Error 1
make: *** [subdir-nanox] Error 2

i have no idea to fix this. can you help me please.


-- 
Cheers
Vijaya Chandran.M

------=_Part_4283_12361670.1223378959082
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><br clear="all"><font class="swb">Hello,<br>

<br>

I am trying to port Microwindow on MIPS based Hardware.<br>
<br>

While crosscompiling Microwindows (microwindows-src-snapshot.tar.gz) for <br>

MIPS, i am getting linking error.<br>

<br>

Linking /opt/stb/microwindows-0.90/src/bin/nano-X ...<br>

/opt/stb/crosstools/bin/../lib/gcc/mipsel-linux-uclibc/3.4.6/../../../../mipsel-linux-uclibc/bin/ld: <br>

warning: ld-uClibc.so.0, needed by <br>

/opt/stb/crosstools/bin/../lib/gcc/mipsel-linux-uclibc/3.4.6/../../../../mipsel-linux-uclibc/lib/libc.so, <br>

not found (try using -rpath or -rpath-link)<br>

/opt/stb/crosstools/bin/../lib/gcc/mipsel-linux-uclibc/3.4.6/../../../../mipsel-linux-uclibc/lib/libc.so: <br>

undefined reference to `__libc_stack_end&#39;<br>

collect2: ld returned 1 exit status<br>

make[1]: *** [/opt/stb/microwindows-0.90/src/bin/nano-X] Error 1<br>

make: *** [subdir-nanox] Error 2<br>

<br>

i have no idea to fix this. can you help me please.<br>

<br>

</font><br>-- <br>Cheers<br>Vijaya Chandran.M<br>
</div>

------=_Part_4283_12361670.1223378959082--
