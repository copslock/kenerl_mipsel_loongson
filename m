Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Sep 2006 07:55:58 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.238]:17061 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038727AbWIEGzv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Sep 2006 07:55:51 +0100
Received: by wx-out-0506.google.com with SMTP id h30so2540377wxd
        for <linux-mips@linux-mips.org>; Mon, 04 Sep 2006 23:55:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=qIaGYaGjsH6ZJV8QbZt80md7yE8lUjJMAE1g7W+0eo7TqMD0CCbZnr/fLNbLfb5nQs6eU5jItxrPX40qapFnD34oIHrbfOv7ZTXlWx34O121YVfYVsufTYPyUqWHvxMmkXDoI4O3Q1HJZa8x6HzCIrEox48Y+HhCDwmES8s6u/w=
Received: by 10.70.118.4 with SMTP id q4mr7061962wxc;
        Mon, 04 Sep 2006 23:55:18 -0700 (PDT)
Received: by 10.70.25.11 with HTTP; Mon, 4 Sep 2006 23:55:18 -0700 (PDT)
Message-ID: <f21fe8a50609042355o19ab7b50nb5717bfe0d358232@mail.gmail.com>
Date:	Tue, 5 Sep 2006 08:55:18 +0200
From:	"Erik Niessen" <erik.niessen@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Weird output from pmap
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_123085_32158524.1157439318223"
Return-Path: <erik.niessen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik.niessen@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_123085_32158524.1157439318223
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am using an embedded development board with a mips 4kEC on it. I use
buildroot for building a
rootfs and the toolchain.

I cross compiled a helloword app.
When I look at the output of pmap I see the following

/helloworldmips(86)
00400000 (4 KB)        r-xp (00:0a 33243002)   linux/test/helloworldmips
10000000 (4 KB)        rw-p (00:0a 33243002)   linux/test/helloworldmips
10001000 (4 KB)        rwxp (00:00 0)        [heap]
2aaa8000 (20 KB)       r-xp (00:07 1795853)
/lib/ld-uClibc-0.9.27.so<http://uclibc-0.9.27.so/>
2aaad000 (4 KB)        rw-p (00:00 0)
2aaed000 (4 KB)        rw-p (00:07 1795853)  /lib/ld-
uClibc-0.9.27.so<http://uclibc-0.9.27.so/>
2aaee000 (48 KB)       r-xp (00:07 1795861)  /lib/libgcc_s.so.1
2aafa000 (252 KB)      ---p (00:00 0)
2ab39000 (4 KB)        rw-p (00:07 1795861)  /lib/libgcc_s.so.1
2ab3a000 (368 KB)      r-xp (00:07 1795855)  /lib/libuClibc-0.9.27.so
2ab96000 (256 KB)      ---p (00:00 0)
2abd6000 (8 KB)        rw-p (00:07 1795855)  /lib/libuClibc- 0.9.27.so
2abd8000 (16 KB)       rw-p (00:00 0)
7fd49000 (84 KB)       rwxp (00:00 0)        [stack]
mapped:   1076 KB writable/private: 128 KB shared: 0 KB

It seems that the bss segments of the shared libs are protected and mapped
to the zero page. I don't see this
when I run this on a linux pc. I have the following questions:
- Why is this segment protected? Accessing results in a seg fault.
- Why is it so big (252k/256K)?
- How much memory is physically allocated for this segment?

Thanks for reading sofar

Erik Niessen

------=_Part_123085_32158524.1157439318223
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I am using an embedded development board with a mips 4kEC on it. I use buildroot for building a <br>rootfs and the toolchain.<br><br>I cross compiled a helloword app.<br>When I look at the output of pmap I see the following
<br><br>/helloworldmips(86)<br>00400000 (4 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r-xp (00:0a 33243002)&nbsp;&nbsp; linux/test/helloworldmips<br><div>10000000 (4 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rw-p (00:0a 33243002)&nbsp;&nbsp; linux/test/helloworldmips
<br>10001000 (4 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rwxp (00:00 0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [heap]<br>2aaa8000 (20 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r-xp (00:07 1795853)&nbsp; /lib/ld-<a href="http://uclibc-0.9.27.so/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">uClibc-0.9.27.so
</a><br>2aaad000 (4 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rw-p (00:00 0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>2aaed000 (4 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rw-p (00:07 1795853)&nbsp; /lib/ld-
<a href="http://uclibc-0.9.27.so/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">uClibc-0.9.27.so</a><br>2aaee000 (48 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r-xp (00:07 1795861)&nbsp; /lib/libgcc_s.so.1<br>2aafa000 (252 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---p (00:00 0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<br>2ab39000 (4 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rw-p (00:07 1795861)&nbsp; /lib/libgcc_s.so.1
<br>2ab3a000 (368 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r-xp (00:07 1795855)&nbsp; /lib/libuClibc-<a href="http://0.9.27.so/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">0.9.27.so</a><br>2ab96000 (256 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---p (00:00 0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<br>2abd6000 (8 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rw-p (00:07 1795855)&nbsp; /lib/libuClibc-<a href="http://0.9.27.so/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
0.9.27.so</a><br>2abd8000 (16 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rw-p (00:00 0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>7fd49000 (84 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rwxp (00:00 0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [stack]<br>mapped:&nbsp;&nbsp; 1076 KB writable/private: 128 KB shared: 0 KB<br><br>It seems that the bss segments of the shared libs are protected and mapped to the zero page. I don't see this
<br>when I run this on a linux pc. I have the following questions:<br>- Why is this segment protected? Accessing results in a seg fault.<br>- Why is it so big (252k/256K)?<br>- How much memory is physically allocated for this segment?
<br><br>Thanks for reading sofar<br><br>Erik Niessen<br></div>

------=_Part_123085_32158524.1157439318223--
