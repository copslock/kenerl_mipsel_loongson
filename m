Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g25KTo017019
	for linux-mips-outgoing; Tue, 5 Mar 2002 12:29:50 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g25KTn917016
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 12:29:49 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g25JTWn4002206;
	Tue, 5 Mar 2002 11:29:32 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g25JTWpL002202;
	Tue, 5 Mar 2002 11:29:32 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 5 Mar 2002 11:29:32 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Andre.Messerschmidt@infineon.com
cc: linux-mips@oss.sgi.com
Subject: Re: Console problem
In-Reply-To: <86048F07C015D311864100902760F1DD01B5E74B@dlfw003a.dus.infineon.com>
Message-ID: <Pine.LNX.4.10.10203051129070.29682-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> I wrote my own console driver based on the ARC console driver (to keep it
> simple). When I am booting my modified 2.4.3 kernel, I get an "unable to
> open initial console" error (code: No such device). I have tracked it down
> to the point where the kernel searches for a valid TTY device with major and
> minor ID 4:64. 
> All devices that are present at this time are: 3:0-3:256 2:0-2:256 5:0 5:1.
> Obviously there is no 4:64 device.

Did you call register_console ?
