Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB9LptD19554
	for linux-mips-outgoing; Sun, 9 Dec 2001 13:51:55 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fB9Lppo19550
	for <linux-mips@oss.sgi.com>; Sun, 9 Dec 2001 13:51:51 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fB9Kpnm17390
	for linux-mips@oss.sgi.com; Sun, 9 Dec 2001 18:51:49 -0200
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB73jro10568
	for <linux-mips@oss.sgi.com>; Thu, 6 Dec 2001 19:45:53 -0800
Message-Id: <200112070345.fB73jro10568@oss.sgi.com>
Received: (qmail 15287 invoked from network); 7 Dec 2001 02:40:32 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 7 Dec 2001 02:40:32 -0000
Date: Fri, 7 Dec 2001 3:7:4 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Hartvig Ekner <hartvige@mips.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: XF86Config & startup log
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====_Dragon665211358614_====="
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

--=====_Dragon665211358614_=====
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable

hi,Hartvig Ekner=A3=AC
   Here are my files.
   but the build process can't be described in short:(.
   I started from a rpm package from redhat7(or similar standard=
 distribution),did
everything to make it cross-compile,very ugly and=
 painful.Basically, 
     repeat if errors
       make World &> out,
       read out,correct errors it reports
     until done
   beside changes to config files,i remember there were problems=
 due to the sequence
when it cross-builded a problem and wanted to execute it.
  From the list,I think someone else should have more elegant=
 way. And i will try 
H.J.Lu's source in oss.sgi.com when having time.

=D4=DA 2001-12-06 21:10:00 you wrote=A3=BA
>Hello Zhang,
>
>I would be very interested in trying to get the video support=
 (using G200
>as you have) up and running on our Malta board with full X.
>
>Could you provide me with some more info, so that I can try to=
 repeat it?
>E.g. the /etc/X11/XF86Config file, exactly what X server did you=
 use, 
>startup output when starting the server (cut & paste, or from
>/var/log/XFree86.0.log or similar).
>
>Any information much appreciated!
>
>/Hartvig
>
>Zhang Fuxin writes:
>> 
>> hi,Alinux-mips,
>>    Finally the 2.4 kernel seems calm down,I pay some time to=
 cleanup
>> my code for algorithmics p6032 board.
>>    Although it may still very experimental,i make it public=
 here 
>> hoping that it will save  sometime for someone else.
>>    You can get the source diff
>>    (against sgi cvs linux_2_4_branch Dec.3,about 50k) from: 
>>    http://159.226.40.150/godson/mips-2.4.16-zfx.diff.gz
>>      (sorry i haven't a dns name)
>> 
>>   I am eager to get some feedback.
>> 
>>   There are Changelog and README in arch/mips/algor/
>> 
>>  for your convenience,READ is post here:
>> 
>>     This is my code for algor p6032,many of them=
 borrowed/inherit from
>> algorithmics' 2.2 kernel(and others),but with a lot of=
 cleanup(i think:)
>> I have tried my best to make minimum changes to generic code.
>> 
>>   Testing platform:
>>       Algorithmics p6032 eval board,idt RC64474 CPU
>>       (with a 40G IBM 7200rpm ide disk,256M sdram=
 memory,matrox G200 video
>>        card)
>>       Software: H.J.Lu's cross compile toolchain & redhat 7.1=
 port)
>>   Features:
>>       1.new time,new irq,new pci,auto-pci,etc
>>       see this list:
>>       CONFIG_PCI=3Dy
>>       CONFIG_NEW_PCI=3Dy
>>       CONFIG_PCI_AUTO=3Dy
>>       CONFIG_NEW_IRQ=3Dy
>>       CONFIG_I8259=3Dy
>>       CONFIG_HAVE_STD_PC_SERIAL_PORT=3Dy
>>       CONFIG_NEW_TIME_C=3Dy
>>       CONFIG_BOARD_SCACHE=3Dy
>>       CONFIG_PC_KEYB=3Dy
>>       CONFIG_NONCOHERENT_IO=3Dy
>> 
>>       2. frame buffer for matrox cards(that means you can use=
 X windows)
>>       3. a flash driver for easily rewriting of on board=
 flash
>>       4. ide,ethernet(pcnet32) with dma
>>       5. with 2.4.16 patch(filesystem corruption fixed)
>> 
>>    TODO:
>>       1. more test,e.g. with ltp or something
>>          I have run 2.4.8 for some time with good stablity,but=
 this upgrade is
>> =09 done in one day,with many cleanups
>> =09 it will surely contain some bugs
>>       2. on board cache support
>>          i haven't decided a elegant way to support the board=
 cache
>>       3. 
>> 
>>    Important Notes:
>>       1. the command line is fixed at arch/mips/kernel/setup.c=
 for my convenience:),you should change to fit your need or=
 comment it out and use pmon args
>>       2. PIIX support for ide must be choosed,or the irq probe=
 will lead to
>>          endless interruption.
>>       
>>    More information may present in Changelog.zfx.
>> 
>> 
>>                    2001.12.05 Zhang Fuxin,=
 <fxzhang@ict.ac.cn>
>> =09=09   Institute of Computing Technology,Chinese Academy of=
 Sciences
>> 
>> have to get some sleep now:)
>> 
>> Regards
>>             Zhang Fuxin
>>             fxzhang@ict.ac.cn
>> 
>
>
>-- 
> _    _   _____  ____     Hartvig Ekner       =
 Mailto:hartvige@mips.com
> |\  /| | |____)(____                          Direct: +45 4486=
 5503
> | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486=
 5555
>T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486=
 5556

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn

--=====_Dragon665211358614_=====
Content-Type: application/octet-stream; name="XF86Config-4"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="XF86Config-4"

CiMgRmlsZSBnZW5lcmF0ZWQgYnkgWEZkcmFrZS4KCiMgKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgojIFJlZmVyIHRv
IHRoZSBYRjg2Q29uZmlnKDQvNSkgbWFuIHBhZ2UgZm9yIGRldGFpbHMgYWJvdXQgdGhlIGZvcm1h
dCBvZgojIHRoaXMgZmlsZS4KIyAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCgpTZWN0aW9uICJGaWxlcyIKCiAgICBS
Z2JQYXRoCSIvdXNyL1gxMVI2L2xpYi9YMTEvcmdiIgoKIyBNdWx0aXBsZSBGb250UGF0aCBlbnRy
aWVzIGFyZSBhbGxvd2VkICh0aGV5IGFyZSBjb25jYXRlbmF0ZWQgdG9nZXRoZXIpCiMgQnkgZGVm
YXVsdCwgTWFuZHJha2UgNi4wIGFuZCBsYXRlciBub3cgdXNlIGEgZm9udCBzZXJ2ZXIgaW5kZXBl
bmRlbnQgb2YKIyB0aGUgWCBzZXJ2ZXIgdG8gcmVuZGVyIGZvbnRzLgoKICAgRm9udFBhdGggICAg
Ii91c3IvWDExUjYvbGliL1gxMS9mb250cy9taXNjIgogICBGb250UGF0aCAgICAiL3Vzci9zaGFy
ZS9mb250cy9kZWZhdWx0L1R5cGUxIgogICBGb250UGF0aCAgICAiL3Vzci9zaGFyZS9mb250cy9k
ZWZhdWx0L2dob3N0c2NyaXB0IgoKRW5kU2VjdGlvbgoKIyAqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiMgU2VydmVy
IGZsYWdzIHNlY3Rpb24uCiMgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgoKU2VjdGlvbiAiU2VydmVyRmxhZ3MiCgog
ICAgIyBVbmNvbW1lbnQgdGhpcyB0byBjYXVzZSBhIGNvcmUgZHVtcCBhdCB0aGUgc3BvdCB3aGVy
ZSBhIHNpZ25hbCBpcwogICAgIyByZWNlaXZlZC4gIFRoaXMgbWF5IGxlYXZlIHRoZSBjb25zb2xl
IGluIGFuIHVudXNhYmxlIHN0YXRlLCBidXQgbWF5CiAgICAjIHByb3ZpZGUgYSBiZXR0ZXIgc3Rh
Y2sgdHJhY2UgaW4gdGhlIGNvcmUgZHVtcCB0byBhaWQgaW4gZGVidWdnaW5nCiAgICAjTm9UcmFw
U2lnbmFscwoKICAgICMgVW5jb21tZW50IHRoaXMgdG8gZGlzYWJsZSB0aGUgPENydGw+PEFsdD48
QlM+IHNlcnZlciBhYm9ydCBzZXF1ZW5jZQogICAgIyBUaGlzIGFsbG93cyBjbGllbnRzIHRvIHJl
Y2VpdmUgdGhpcyBrZXkgZXZlbnQuCiAgICAjRG9udFphcAoKICAgICMgVW5jb21tZW50IHRoaXMg
dG8gZGlzYWJsZSB0aGUgPENydGw+PEFsdD48S1BfKz4vPEtQXy0+IG1vZGUgc3dpdGNoaW5nCiAg
ICAjIHNlcXVlbmNlcy4gIFRoaXMgYWxsb3dzIGNsaWVudHMgdG8gcmVjZWl2ZSB0aGVzZSBrZXkg
ZXZlbnRzLgogICAgI0RvbnRab29tCgogICAgIyBUaGlzICBhbGxvd3MgIHRoZSAgc2VydmVyICB0
byBzdGFydCB1cCBldmVuIGlmIHRoZQogICAgIyBtb3VzZSBkZXZpY2UgY2FuJ3QgYmUgb3BlbmVk
L2luaXRpYWxpc2VkLgogICAgQWxsb3dNb3VzZU9wZW5GYWlsCgpFbmRTZWN0aW9uCgojICoqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioKIyBJbnB1dCBkZXZpY2VzCiMgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgoKIyAqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
CiMgS2V5Ym9hcmQgc2VjdGlvbgojICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKClNlY3Rpb24gIklucHV0RGV2aWNl
IgoKICAgIElkZW50aWZpZXIgIktleWJvYXJkMSIKICAgIERyaXZlciAgICAgICJLZXlib2FyZCIK
ICAgIE9wdGlvbiAiQXV0b1JlcGVhdCIgICIyNTAgMzAiCgogICAgI09wdGlvbiAiWGtiUnVsZXMi
ICJ4ZnJlZTg2IgogICAgI09wdGlvbiAiWGtiTW9kZWwiICJwYzEwNSIKICAgICNPcHRpb24gIlhr
YkxheW91dCIgInVzIgoKRW5kU2VjdGlvbgoKIyAqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiMgUG9pbnRlciBzZWN0
aW9uCiMgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKgoKU2VjdGlvbiAiSW5wdXREZXZpY2UiCgogICAgSWRlbnRpZmll
ciAgIk1vdXNlMSIKICAgIERyaXZlciAgICAgICJtb3VzZSIKICAgIE9wdGlvbiAiUHJvdG9jb2wi
ICAgICJQUy8yIgogICAgT3B0aW9uICJEZXZpY2UiICAgICAgIi9kZXYvcHNhdXgiCiAgICAjT3B0
aW9uICJFbXVsYXRlM0J1dHRvbnMiCiAgICAjT3B0aW9uICJFbXVsYXRlM1RpbWVvdXQiICAgICI1
MCIKCiMgQ2hvcmRNaWRkbGUgaXMgYW4gb3B0aW9uIGZvciBzb21lIDMtYnV0dG9uIExvZ2l0ZWNo
IG1pY2UKCiMgICAgT3B0aW9uICJDaG9yZE1pZGRsZSIKCkVuZFNlY3Rpb24KCgoKU2VjdGlvbiAi
TW9kdWxlIgoKIyBUaGlzIGxvYWRzIHRoZSBEQkUgZXh0ZW5zaW9uIG1vZHVsZS4KCiMgICAgTG9h
ZAkiZGJlIgoKCiMgVGhpcyBsb2FkcyB0aGUgbWlzY2VsbGFuZW91cyBleHRlbnNpb25zIG1vZHVs
ZSwgYW5kIGRpc2FibGVzCiMgaW5pdGlhbGlzYXRpb24gb2YgdGhlIFhGcmVlODYtREdBIGV4dGVu
c2lvbiB3aXRoaW4gdGhhdCBtb2R1bGUuCgogICAgI1N1YlNlY3Rpb24JImV4dG1vZCIKCSNPcHRp
b24JIm9taXQgeGZyZWU4Ni1kZ2EiCiAgICAjRW5kU3ViU2VjdGlvbgoKIyBUaGlzIGxvYWRzIHRo
ZSBUeXBlMSBhbmQgRnJlZVR5cGUgZm9udCBtb2R1bGVzCgojICAgIExvYWQJInR5cGUxIgojICAg
IExvYWQJImZyZWV0eXBlIgpFbmRTZWN0aW9uCgojICoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKIyBNb25pdG9yIHNl
Y3Rpb24KIyAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqCgojIEFueSBudW1iZXIgb2YgbW9uaXRvciBzZWN0aW9ucyBt
YXkgYmUgcHJlc2VudAoKU2VjdGlvbiAiTW9uaXRvciIKICAgIElkZW50aWZpZXIgIk1vbml0b3Iw
IgogICAgVmVuZG9yTmFtZSAiTW9uaXRvciBWZW5kb3IiCiAgICBNb2RlbE5hbWUgICJNb25pdG9y
IE1vZGVsIgoKCiMgSG9yaXpTeW5jIGlzIGluIGtIeiB1bmxlc3MgdW5pdHMgYXJlIHNwZWNpZmll
ZC4KIyBIb3JpelN5bmMgbWF5IGJlIGEgY29tbWEgc2VwYXJhdGVkIGxpc3Qgb2YgZGlzY3JldGUg
dmFsdWVzLCBvciBhCiMgY29tbWEgc2VwYXJhdGVkIGxpc3Qgb2YgcmFuZ2VzIG9mIHZhbHVlcy4K
IyBOT1RFOiBUSEUgVkFMVUVTIEhFUkUgQVJFIEVYQU1QTEVTIE9OTFkuICBSRUZFUiBUTyBZT1VS
IE1PTklUT1InUwojIFVTRVIgTUFOVUFMIEZPUiBUSEUgQ09SUkVDVCBOVU1CRVJTLgogICAgSG9y
aXpTeW5jICAzMC4wLTU0LjAKCgojIFZlcnRSZWZyZXNoIGlzIGluIEh6IHVubGVzcyB1bml0cyBh
cmUgc3BlY2lmaWVkLgojIFZlcnRSZWZyZXNoIG1heSBiZSBhIGNvbW1hIHNlcGFyYXRlZCBsaXN0
IG9mIGRpc2NyZXRlIHZhbHVlcywgb3IgYQojIGNvbW1hIHNlcGFyYXRlZCBsaXN0IG9mIHJhbmdl
cyBvZiB2YWx1ZXMuCiMgTk9URTogVEhFIFZBTFVFUyBIRVJFIEFSRSBFWEFNUExFUyBPTkxZLiAg
UkVGRVIgVE8gWU9VUiBNT05JVE9SJ1MKIyBVU0VSIE1BTlVBTCBGT1IgVEhFIENPUlJFQ1QgTlVN
QkVSUy4KICAgIFZlcnRSZWZyZXNoIDUwLjAtMTEwLjAKCgpFbmRTZWN0aW9uCgoKCiMgKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKgojIEdyYXBoaWNzIGRldmljZSBzZWN0aW9uCiMgKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgoKI1NlY3Rp
b24gIkRldmljZSIKIyAgICBJZGVudGlmaWVyICJHZW5lcmljIFZHQSIKIyAgICBEcml2ZXIgICAg
ICJ2Z2EiCiNFbmRTZWN0aW9uCgpTZWN0aW9uICJEZXZpY2UiCiAgICBJZGVudGlmaWVyICAiUklW
QSBUTlQyIgogICAgVmVuZG9yTmFtZSAgIlVua25vd24iCiAgICBCb2FyZE5hbWUgICAiVW5rbm93
biIKICAgIERyaXZlciAgICAgICJmYmRldiIKICAgIFZpZGVvUmFtICAgIDE2Mzg0CiAgICAjIENs
b2NrIGxpbmVzCiAgICBCdXNJRCAgICAgICAiUENJOjA6MGU6MCIKCiAgICAjIFVuY29tbWVudCBm
b2xsb3dpbmcgb3B0aW9uIGlmIHlvdSBzZWUgYSBiaWcgd2hpdGUgYmxvY2sgICAgICAgIAogICAg
IyBpbnN0ZWFkIG9mIHRoZSBjdXJzb3IhICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCiAgICAjICAgIE9wdGlvbiAgICAgICJzd19jdXJzb3IiCgojIE9wdGlvbiAgICAg
ICJEUE1TIgpFbmRTZWN0aW9uCgoKCiMgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgojIFNjcmVlbiBzZWN0aW9ucwoj
ICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioKCgpTZWN0aW9uICJTY3JlZW4iCiAgICBJZGVudGlmaWVyICJzY3JlZW4x
IgogICAgRGV2aWNlICAgICAgIlJJVkEgVE5UMiIKICAgIE1vbml0b3IgICAgICJNb25pdG9yMCIK
ICAgIERlZmF1bHRDb2xvckRlcHRoIDI0CiAgICBTdWJzZWN0aW9uICJEaXNwbGF5IgogICAgICAg
IERlcHRoICAgICAgIDgKICAgICAgICBNb2RlcyAgICAgICAiODAweDYwMCIgIjY0MHg0MDAiCiAg
ICAgICAgVmlld1BvcnQgICAgMCAwCiAgICBFbmRTdWJzZWN0aW9uCiAgICBTdWJzZWN0aW9uICJE
aXNwbGF5IgogICAgICAgIERlcHRoICAgICAgIDE2CiAgICAgICAgTW9kZXMgICAgICAgIjgwMHg2
MDAiICI2NDB4NDgwIgogICAgICAgIFZpZXdQb3J0ICAgIDAgMAogICAgRW5kU3Vic2VjdGlvbgog
ICAgU3Vic2VjdGlvbiAiRGlzcGxheSIKICAgICAgICBEZXB0aCAgICAgICAyNAogICAgICAgIE1v
ZGVzICAgICAgICI4MDB4NjAwIiAiNjQweDQ4MCIKICAgICAgICBWaWV3UG9ydCAgICAwIDAKICAg
IEVuZFN1YnNlY3Rpb24KICAgIFN1YnNlY3Rpb24gIkRpc3BsYXkiCiAgICAgICAgRGVwdGggICAg
ICAgMzIKICAgICAgICBNb2RlcyAgICAgICAiODAweDYwMCIgIjY0MHg0ODAiCiAgICAgICAgVmll
d1BvcnQgICAgMCAwCiAgICBFbmRTdWJzZWN0aW9uCkVuZFNlY3Rpb24KCg==

--=====_Dragon665211358614_=====
Content-Type: application/octet-stream; name="out"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="out"

CgpYRnJlZTg2IFZlcnNpb24gNC4xLjAgKFJlZCBIYXQgTGludXggcmVsZWFzZTogNC4xLjAtMC45
LjAuMSkgLyBYIFdpbmRvdyBTeXN0ZW0KKHByb3RvY29sIFZlcnNpb24gMTEsIHJldmlzaW9uIDAs
IHZlbmRvciByZWxlYXNlIDY1MTApClJlbGVhc2UgRGF0ZTogMiBKdW5lIDIwMDEKCUlmIHRoZSBz
ZXJ2ZXIgaXMgb2xkZXIgdGhhbiA2LTEyIG1vbnRocywgb3IgaWYgeW91ciBjYXJkIGlzCgluZXdl
ciB0aGFuIHRoZSBhYm92ZSBkYXRlLCBsb29rIGZvciBhIG5ld2VyIHZlcnNpb24gYmVmb3JlCgly
ZXBvcnRpbmcgcHJvYmxlbXMuICAoU2VlIGh0dHA6Ly93d3cuWEZyZWU4Ni5PcmcvRkFRKQpCdWls
ZCBPcGVyYXRpbmcgU3lzdGVtOiBMaW51eCAyLjQuNiBpNjg2IFtFTEZdIAooPT0pIExvZyBmaWxl
OiAiL3Zhci9sb2cvWEZyZWU4Ni4wLmxvZyIsIFRpbWU6IFR1ZSBBcHIgMTcgMDI6MDY6MTMgMjAw
MQooPT0pIFVzaW5nIGNvbmZpZyBmaWxlOiAiL2V0Yy9YMTEvWEY4NkNvbmZpZy00IgpNYXJrZXJz
OiAoLS0pIHByb2JlZCwgKCoqKSBmcm9tIGNvbmZpZyBmaWxlLCAoPT0pIGRlZmF1bHQgc2V0dGlu
ZywKICAgICAgICAgKCsrKSBmcm9tIGNvbW1hbmQgbGluZSwgKCEhKSBub3RpY2UsIChJSSkgaW5m
b3JtYXRpb25hbCwKICAgICAgICAgKFdXKSB3YXJuaW5nLCAoRUUpIGVycm9yLCAoTkkpIG5vdCBp
bXBsZW1lbnRlZCwgKD8/KSB1bmtub3duLgooV1cpIE5vIExheW91dCBzZWN0aW9uLiAgVXNpbmcg
dGhlIGZpcnN0IFNjcmVlbiBzZWN0aW9uLgooKiopIHwtLT5TY3JlZW4gInNjcmVlbjEiICgwKQoo
KiopIHwgICB8LS0+TW9uaXRvciAiTW9uaXRvcjAiCigqKikgfCAgIHwtLT5EZXZpY2UgIlJJVkEg
VE5UMiIKKD09KSB8LS0+SW5wdXQgRGV2aWNlICJNb3VzZTEiCig9PSkgfC0tPklucHV0IERldmlj
ZSAiS2V5Ym9hcmQxIgooV1cpIGBmb250cy5kaXInIG5vdCBmb3VuZCAob3Igbm90IHZhbGlkKSBp
biAiL3Vzci9zaGFyZS9mb250cy9kZWZhdWx0L2dob3N0c2NyaXB0Ii4KCUVudHJ5IGRlbGV0ZWQg
ZnJvbSBmb250IHBhdGguCgkoUnVuICdta2ZvbnRkaXInIG9uICIvdXNyL3NoYXJlL2ZvbnRzL2Rl
ZmF1bHQvZ2hvc3RzY3JpcHQiKS4KKCoqKSBGb250UGF0aCBzZXQgdG8gIi91c3IvWDExUjYvbGli
L1gxMS9mb250cy9taXNjLC91c3Ivc2hhcmUvZm9udHMvZGVmYXVsdC9UeXBlMSIKKCoqKSBSZ2JQ
YXRoIHNldCB0byAiL3Vzci9YMTFSNi9saWIvWDExL3JnYiIKKC0tKSB1c2luZyBWVCBudW1iZXIg
NAoKKC0tKSBQQ0k6ICgwOjE0OjApIHVua25vd24gdmVuZG9yICgweDJiMTApIHVua25vd24gY2hp
cHNldCAoMHgyMDA1KSByZXYgMSwgTWVtIEAgMHgwMGMwNmUwMC8xNCwgMHgwMDAwODAwMC8yMywg
SS9PIEAgMHg4MDAwMDA4LzI0LCBCSU9TIEAgMHgwMTAwNjgwMC8xNgooSUkpIE5WOiBkcml2ZXIg
Zm9yIE5WSURJQSBjaGlwc2V0czogUklWQTEyOCwgUklWQVROVCwgUklWQVROVDIsCglSSVZBVE5U
MiAoQSksIFJJVkFUTlQyIChCKSwgUklWQVROVDIgKFVsdHJhKSwgUklWQVROVDIgKFZhbnRhKSwK
CVJJVkFUTlQyIE02NCwgUklWQVROVDIgKEludGVncmF0ZWQpLCBHZUZvcmNlIDI1NiwgR2VGb3Jj
ZSBERFIsCglRdWFkcm8sIEdlRm9yY2UyIEdUUywgR2VGb3JjZTIgR1RTIChyZXYgMSksIEdlRm9y
Y2UyIHVsdHJhLAoJUXVhZHJvIDIgUHJvLCBHZUZvcmNlMiBNWCwgR2VGb3JjZTIgTVggRERSLCBR
dWFkcm8gMiBNWFIsCglHZUZvcmNlIDIgR28sIEdlRm9yY2UzLCBHZUZvcmNlMyAocmV2IDEpLCBH
ZUZvcmNlMyAocmV2IDIpLAoJR2VGb3JjZTMgKHJldiAzKQooSUkpIEZCRGV2OiBkcml2ZXIgZm9y
IGZyYW1lYnVmZmVyOiBmYmRldgooSUkpIEZCRGV2KDApOiB1c2luZyBkZWZhdWx0IGRldmljZQoo
SUkpIFJ1bm5pbmcgaW4gRlJBTUVCVUZGRVIgTW9kZQooKiopIEZCRGV2KDApOiBEZXB0aCAyNCwg
KC0tKSBmcmFtZWJ1ZmZlciBicHAgMzIKKD09KSBGQkRldigwKTogUkdCIHdlaWdodCA4ODgKKD09
KSBGQkRldigwKTogRGVmYXVsdCB2aXN1YWwgaXMgVHJ1ZUNvbG9yCig9PSkgRkJEZXYoMCk6IFVz
aW5nIGdhbW1hIGNvcnJlY3Rpb24gKDEuMCwgMS4wLCAxLjApCihJSSkgRkJEZXYoMCk6IEhhcmR3
YXJlOiBNQVRST1ggKHZpZG1lbTogMTYzODRrKQooSUkpIEZCRGV2KDApOiBDaGVja2luZyBNb2Rl
cyBhZ2FpbnN0IGZyYW1lYnVmZmVyIGRldmljZS4uLgooSUkpIEZCRGV2KDApOiAJbW9kZSAiODAw
eDYwMCIgb2sKKElJKSBGQkRldigwKTogCW1vZGUgIjY0MHg0ODAiIG9rCihJSSkgRkJEZXYoMCk6
IENoZWNraW5nIE1vZGVzIGFnYWluc3QgbW9uaXRvci4uLgooLS0pIEZCRGV2KDApOiBWaXJ0dWFs
IHNpemUgaXMgODAweDYwMCAocGl0Y2ggODAwKQooKiopIEZCRGV2KDApOiBEZWZhdWx0IG1vZGUg
IjgwMHg2MDAiOiAzNi4wIE1IeiAoc2NhbGVkIGZyb20gMC4wIE1IeiksIDM1LjIga0h6LCA1Ni4y
IEh6CigqKikgRkJEZXYoMCk6IERlZmF1bHQgbW9kZSAiNjQweDQ4MCI6IDI1LjIgTUh6IChzY2Fs
ZWQgZnJvbSAwLjAgTUh6KSwgMzEuNSBrSHosIDYwLjAgSHoKKD09KSBGQkRldigwKTogRFBJIHNl
dCB0byAoNzUsIDc1KQooKiopIEZCRGV2KDApOiBVc2luZyAiU2hhZG93IEZyYW1lYnVmZmVyIgoo
LS0pIERlcHRoIDI0IHBpeG1hcCBmb3JtYXQgaXMgMzIgYnBwCig9PSkgRkJEZXYoMCk6IEJhY2tp
bmcgc3RvcmUgZGlzYWJsZWQKZXJyb3Igb3BlbmluZyBzZWN1cml0eSBwb2xpY3kgZmlsZSAvZXRj
L1gxMS94c2VydmVyL1NlY3VyaXR5UG9saWN5CigqKikgTW91c2UxOiBQcm90b2NvbDogIlBTLzIi
CigqKikgTW91c2UxOiBDb3JlIFBvaW50ZXIKKD09KSBNb3VzZTE6IEJ1dHRvbnM6IDMKKElJKSBL
ZXlib2FyZCAiS2V5Ym9hcmQxIiBoYW5kbGVkIGJ5IGxlZ2FjeSBkcml2ZXIKKElJKSBYSU5QVVQ6
IEFkZGluZyBleHRlbmRlZCBpbnB1dCBkZXZpY2UgIk1vdXNlMSIgKHR5cGU6IE1PVVNFKQpXYXJu
aW5nOiBsb2NhbGUgbm90IHN1cHBvcnRlZCBieSBDIGxpYnJhcnksIGxvY2FsZSB1bmNoYW5nZWQK
V2FybmluZzogbG9jYWxlIG5vdCBzdXBwb3J0ZWQgYnkgWGxpYiwgbG9jYWxlIHNldCB0byBDCldh
cm5pbmc6IFggbG9jYWxlIG1vZGlmaWVycyBub3Qgc3VwcG9ydGVkLCB1c2luZyBkZWZhdWx0CkZh
aWxlZCB0byBvcGVuIGlucHV0IG1ldGhvZAo=

--=====_Dragon665211358614_=====--
