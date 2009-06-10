Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2009 15:04:16 +0100 (WEST)
Received: from web23605.mail.ird.yahoo.com ([87.248.115.48]:35571 "HELO
	web23605.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20022918AbZFJOEK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jun 2009 15:04:10 +0100
Received: (qmail 70174 invoked by uid 60001); 10 Jun 2009 14:04:03 -0000
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s1024; t=1244642643; bh=CHyneAIaRrsLcyop2kIpTnMxX+HIGrENFrLM6nTI55g=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=X+5wE9iAXogeUYF5d2SgcU0m5x78hNgjYMnEsGVnXWW2cTjWgJOMHICQMDBHwzEPOBl4BzzlCZj8I/D2+xrP4wqDNFgS+ly5Ny1JO3yr+gq8bEUrszXRQhFu90qSzro9JMX36I2VcoGkK5a9tznEoZW22h72/zYtDC5w/TGtBlQ=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=E+PHTiFd9SQSc5+w+VoRF8qvM8iS/L2KgGqeSd9DINJw0EegKT+fgWdOmYWMq1whBsH7hvWoOFSAKwF55EY7bDR8/a//DjPFNEz6VuoqX3MXWZkMpBRd86x0HgUWWw/GhNEGLfhO2rtYO4STe0wev2Jhp+rbZVU2jmP8EqjAoOQ=;
Message-ID: <137040.69938.qm@web23605.mail.ird.yahoo.com>
X-YMail-OSG: gpHfBWwVM1kJvrXVyt7WN9zWU3xMj.se5fPg2QhdvMvLearrZ3ZgN3aXfA6xDZeoq5a99Z0CFAenzkH5Op1yA7UadqfjOH7NSGKsla39iyyIrlfxyUObs0vruTIGdoDURKuYxoQ5BrBG91lSeo.zkMbToNYJ17fes_9oAPRaMRlDjt1F1mHCnnj8Hi0lwH1rGt22PZ2DcS8VfMQ.ssBKoSLr_B0jXCig29r.Ky4RtmLPXODu_2uOlj002fKmfbGpExxpf0MDYJmHKrEhbWviAHrb1fyXjkTlbYeQ2PB00KVEKu4b44XwrsoWpCQbJON0LTXguDI-
Received: from [83.166.184.142] by web23605.mail.ird.yahoo.com via HTTP; Wed, 10 Jun 2009 14:04:03 GMT
X-Mailer: YahooMailClassic/5.4.12 YahooMailWebService/0.7.289.15
Date:	Wed, 10 Jun 2009 14:04:03 +0000 (GMT)
From:	Glyn Astill <glynastill@yahoo.co.uk>
Subject: Qube2 slowly dies
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <glynastill@yahoo.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glynastill@yahoo.co.uk
Precedence: bulk
X-list: linux-mips


Hi people,

I've been directed here from the Debian lists by Martin Michlmayr. I'm running lenny on a qube2 128mb ram / 40gb disk.

I've tried kernels 2.6.26 and 2.6.30~rc8 and the issue I'm about to describe is present in both, I haven't tried any other kernels - but I will try 2.6.22 when I can.

Essentially the machine gets more and more sluggish until it finally dies. I've had a quick look in meminfo and I can't see that it's running out of memory, and I'm not sure what else to check?

I find it hard to describe what's going off, but here's a scenario I hope illustrates the problem. The configure script is just an example of doing something - I could easily have extracted an archive with tar or something for the same results;

- I start 2 ssh sessions and in one start configure for the postgres source, in the other I just started top.

- And for a while all seems fine; configure ticks away and top refreshes every second.

- Then top stops ticking over - but it'll refresh with a keypress. Anyway I exit top and try to run it again... nothing. I hit ctrl-c which brings me back to the prompt and I try again... nothing.

- The configure script is still ticking over slowly.

- I try "ps ax" - it works; so I try it again... nothing.

- I try "ipcs" and "lsof" they both work and seem to keep working.

- I try "ps ax" again... nothing. I hit ctrl-c and now it doesn't come back to the command prompt for a while.. say 5 minutes and eventually it's back.

- It's still going. Some commands still work, some just do nothing. proc/meminfo shows it's not eaten all the memory.

- If I try to start another ssh session I can log in, I get the motd, but I don't get to the shell.

- Eventually the configure script ends, and all shells come back to the prompt. But it now seems totally braindamaged, I can run "ps ax" but "top" and other commands still do nothing. Heres strace attached to the top process:

deb:~# strace -p 7228
Process 7228 attached - interrupt to quit
_newselect(0, NULL, NULL, NULL, {0, 500013}

- Then after a little while the whole thing becomes unresponsive.


Can anyone confirm they've seen the same behaviour or direct me what to look into?

Thanks
Glyn


      
