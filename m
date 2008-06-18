Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2008 10:45:51 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.154]:63844 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20027250AbYFRJpr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2008 10:45:47 +0100
Received: by fg-out-1718.google.com with SMTP id d23so89629fga.32
        for <linux-mips@linux-mips.org>; Wed, 18 Jun 2008 02:45:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=TUHRSmICQCLWcbylI6g2aJpVDSX4LQfpacyZkqJY7B8=;
        b=FreGFQpG4iTtfz790zULXj10qF+jcnLeIBSogGXkskV0Wr+BfVKWY1huxAh9FlNPgT
         0DK1665XgQa8BGnHKViAiUOVEP16CnvWxN8aN3kvB6VWqU+nUkmslDNPqeBUKZBuPKg2
         kZ7Z0mzNx4s+H5t9FtNAB+7P1RUIHid8+h+uA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=R5/dPZgSnY8YSxGQLebqHMWm5ZuwdShgVIlzx7P/QdpGHzonrpGoE3J6NMW9yUofOG
         XJAtcil7PhPAZTkb0dsaCXYaryjdfYbSMusUw3F54iCf0W96S810JcNuHIVJw5WSloPn
         qhn60PlA1Pe/lk6N+Q6y+ZDEPbr2aWdepO0JQ=
Received: by 10.86.52.6 with SMTP id z6mr485691fgz.48.1213782346605;
        Wed, 18 Jun 2008 02:45:46 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id 4sm13114542fgg.9.2008.06.18.02.45.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Jun 2008 02:45:45 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Subject: Re: Adding(?) XI support to MIPS-Linux?
Date:	Wed, 18 Jun 2008 11:45:38 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@avtrex.com>,
	Thiemo Seufer <ths@networkno.de>,
	Andrew Dyer <adyer@righthandtech.com>
References: <200806091658.10937.brian.foster@innova-card.com> <200806181042.12911.brian.foster@innova-card.com> <4858D735.5020406@paralogos.com>
In-Reply-To: <4858D735.5020406@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200806181145.39078.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Wednesday 18 June 2008 11:36:53 Kevin D. Kissell wrote:
> Brian Foster wrote:
> >  Whilst thinking about the problem and possible solutions,
> >  it occurred to me there could be a defect in the current
> >  trampoline:  Suppose there is a signal, either at point A,
> >  due to <instr> itself, or at point B, which is caught on
> >  this stack, and the user-land signal-handler ‘return’s.
> >
> >  Doesn't the signal-handler/sigreturn stack-frame overwrite
> >  the FP trampoline?   [ ... ]
> 
> When I first integrated the FP emulator into the kernel, back in 2.2.x,
> I seem to recall that someone found this problem and that I came up with
> a tweak to signal stack setup that protected the FP branch delay slot
> trampoline.  Maybe I'm mistaken, or maybe the tweak was lost?

 The error is mine:  I overlooked the tweak.
 Now that you mention it / remind me of it,
 I distinctly recall it; in fact, that was
 what first alerted me to the existance of
 the FP trampoline.

sorry & cheers!
	-blf-
-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
