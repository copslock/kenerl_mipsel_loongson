Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 16:37:35 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:41877 "EHLO
	mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492725AbZKJPh2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Nov 2009 16:37:28 +0100
Received: by gxk2 with SMTP id 2so125079gxk.4
        for <linux-mips@linux-mips.org>; Tue, 10 Nov 2009 07:37:21 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=Ny88cBpvoTSR0B5RKdUN8KJrvux42MgwLxOc8I8gzHc=;
        b=efZ/SdfbsLz4jN6nzwntej62jzdIPmXtBJzKUdL2jQmSl7eeFgx6N6D08LEQFbmr6A
         I6vN5BCDSjv16wbx62200aDYF6uh9urZjlt2Dp70itLYASk64WmYunDBviyYJMvfdK2W
         XpCrbwLASJ+Rr0KL/PNF7Nyt038H/iXT3qBEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=J17ADGl1gw9hrkiiqQZXA9vgZf41Yz910Xlh3Ok4OXGqm4Eh4ZCL2/mYtx5IGgGPSs
         FzEbOatOAJRyeZjzbNDvU1s8bpv830C2U7yvq8NZub10j3N4tO7RTNd31FcZbje1fbif
         aZ5hVBvuAmuLVbdc/vE8RwYcy1ZdBF9sWN8B0=
MIME-Version: 1.0
Received: by 10.91.26.14 with SMTP id d14mr409834agj.84.1257867441082; Tue, 10 
	Nov 2009 07:37:21 -0800 (PST)
Date:	Tue, 10 Nov 2009 23:37:20 +0800
Message-ID: <e997b7420911100737k3563b9a5l5c6463ba078e9d9@mail.gmail.com>
Subject: Could not use printf after init process
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: multipart/alternative; boundary=001485f7c1940011d5047806163f
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

--001485f7c1940011d5047806163f
Content-Type: text/plain; charset=ISO-8859-1

When booting , Kernel could not print on console after calling
run_init_process-->kernel_execve("/sbin/init")

I guess that printf in busybox  might fail  after the init process began.

Any sugguestion on how to trace this problem? Thank you in advance.


Regards,

--001485f7c1940011d5047806163f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>When booting , Kernel could not print on console after calling=A0 run_=
init_process--&gt;kernel_execve(&quot;/sbin/init&quot;) </div>
<div>=A0</div>
<div>I guess that printf in busybox =A0might fail =A0after the init process=
 began.</div>
<div>=A0</div>
<div>Any sugguestion on how to trace this problem? Thank you in advance.</d=
iv>
<div>=A0</div>
<div>=A0</div>
<div>Regards,</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>

--001485f7c1940011d5047806163f--
