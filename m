Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2007 13:18:23 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.175]:33670 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021713AbXCRNSV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Mar 2007 13:18:21 +0000
Received: by ug-out-1314.google.com with SMTP id 40so1204014uga
        for <linux-mips@linux-mips.org>; Sun, 18 Mar 2007 06:17:20 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=jyMOFZvLcLjWmxuJzr1eL6r/sADjxNWj6MIzDbKskJ0GNv3aY+wAxFA0k8mqcYaNmU2u+nrbBAMVpeR+RVcpaWer9sdCmeS+lMhlxY7kGDccrlBov1Gy0Ra6De33UArZLEfOtLa9pzVpfzBJ1ORjJKLvDITTafn2/oqGgRAF3gA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Puia6VTihAmK0CQUFdMKJuiKuv5YqZas8s/Tkmsx454JDrGcUQ3aH1gH52QIB0uixPs+LrQHpMLrrigdrUDsWgcAnLV/QBNZVIN7AjtmAmwLRxijx4p7NIjtoVEl7/fxuVoIOWqmju9iRtyAc8A9iTwu4uBJaGznhTKHxQXLJaw=
Received: by 10.65.237.15 with SMTP id o15mr5499270qbr.1174223822216;
        Sun, 18 Mar 2007 06:17:02 -0700 (PDT)
Received: by 10.114.159.16 with HTTP; Sun, 18 Mar 2007 06:17:02 -0700 (PDT)
Message-ID: <d459bb380703180617i6e50539bx13ad405fb306fe44@mail.gmail.com>
Date:	Sun, 18 Mar 2007 14:17:02 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	"Michael Stickel" <michael@cubic.org>
Subject: Re: Au1500 and TI PCI1510 cardbus
Cc:	linux-mips@linux-mips.org
In-Reply-To: <45FBF0F1.70302@cubic.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_135937_29248647.1174223822137"
References: <d459bb380703161129l769d3f48w744ba0bfdf04fc91@mail.gmail.com>
	 <45FBB9C7.9060800@cubic.org>
	 <d459bb380703170554l3fb40d60h6f68b70472ad7cb@mail.gmail.com>
	 <45FBF0F1.70302@cubic.org>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_135937_29248647.1174223822137
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> I am sory, I meant the datasheet of the Au1500. I do not find the
> paragraph anymore, but can tell you more on monday.


Thank you. I've checked the data book but I've not found anything so
explicit. Paragraph 4.3.10 "Other notes" states:

"The Au1500 PCI contoller cannot be used with external PCI-to-PCI bridges
that have PCI bus-mastering devices on the
secondary bus which target the Au1500 memory."

But this is not exactly an explanation.. I've found nothing regarding race
conditions or delayed transactions. I'll wait eagerly for monday when all
the truths will be revealed. :)

Thanks!!

------=_Part_135937_29248647.1174223822137
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I am sory, I meant the datasheet of the Au1500. I do not find the<br>paragraph anymore, but can tell you more on monday.
</blockquote><div><br>Thank you. I&#39;ve checked the data book but I&#39;ve not found anything so explicit. Paragraph 4.3.10 &quot;Other notes&quot; states:<br><br>&quot;The Au1500 PCI contoller cannot be used with external PCI-to-PCI bridges that have PCI bus-mastering devices on the
<br>secondary bus which target the Au1500 memory.&quot;<br><br>But this is not exactly an explanation.. I&#39;ve found nothing regarding race conditions or delayed transactions. I&#39;ll wait eagerly for monday when all the truths will be revealed. :)
<br><br>Thanks!!<br><br></div></div>

------=_Part_135937_29248647.1174223822137--
