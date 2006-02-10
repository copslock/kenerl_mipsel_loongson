Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 03:03:53 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.197]:60617 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133541AbWBJDDp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2006 03:03:45 +0000
Received: by wproxy.gmail.com with SMTP id 36so462528wra
        for <linux-mips@linux-mips.org>; Thu, 09 Feb 2006 19:09:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=XRvE8K8P7vbg6YLPfz01YC7kqJuCLg4JAK7PKZ695hJx/VxvQsx2FPnhOO88HX1JoKOuFZRI+buWM6LERPEQSPW2lf6/JrIYtahpd3nfCps62Dwotb3CopaSy2Gxb5KXapgNGuTsjyPRyiU3gzvWtuABBTiirv8lxWpgVa+LTgE=
Received: by 10.54.65.6 with SMTP id n6mr2349103wra;
        Thu, 09 Feb 2006 19:09:40 -0800 (PST)
Received: from ?192.168.2.99? ( [24.184.9.219])
        by mx.gmail.com with ESMTP id 34sm2046954wra.2006.02.09.19.09.39;
        Thu, 09 Feb 2006 19:09:40 -0800 (PST)
Message-ID: <43EC03F4.4040805@gmail.com>
Date:	Thu, 09 Feb 2006 22:09:40 -0500
From:	Don Imus <donimus@gmail.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Rogue Branch - can git help here?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <donimus@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: donimus@gmail.com
Precedence: bulk
X-list: linux-mips

I've got an old Linux 2.4.18 source tree I downloaded from a vendor who 
sells devices using MIPS processors with embedded Linux running on them.

There are clearly places in the code where the vendor has made changes. 
  Unfotunately, the vendor used their own CVS and every tagged file 
shows revision 1.1.1.1.

Can GIT help me determine on which date the vendor's tree was originally 
pulled?

I thought of a script call GIT to diff the file against all revisions in 
the repo, possibly creating patch files, and then I could look at the 
number of changes for each as a measure of "closeness".  Doing this for 
several files and finding commonality in the dates would increase the 
probability of finding the right one.

If I copy the vendor source tree into the local GIT tree and commit a 
new branch are there any facilitites in GIT that would tell me which 
older revision, prior to a given date, is the best "match" on the files 
in the tree?

I just started using GIT and maybe the question is better for the GIT 
mailing list but I figured I'd ask it here first and see if anyone has 
already done something like this.

In case anyone's wondering the device ships with a binary-only device 
driver module that will only work with a 2.4.18 kernel and that's why 
I'm stuck in the past on this.
